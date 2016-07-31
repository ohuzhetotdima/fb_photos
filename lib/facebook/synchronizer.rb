class Synchronizer # Facebook::Synchronizer?
  ALBUM_FIELDS = %w(name description cover_photo created_time).freeze
  PHOTO_FIELDS = %w(name images created_time).freeze

  def initialize(user)
    @user    = user
    @fb_user = FbGraph2::User.me(user.oauth_token)
  end

  def sync
    clear_photos
    @fb_user.albums(fields: ALBUM_FIELDS).each do |fb_album|
      album = fetch_album(fb_album)
      fetch_photos(album, fb_album)
    end
  end

  private

  def clear_photos
    # Don't have time to calc differencies between synchronizations, so have to destroy previous sync's albums and photos
    @user.albums.destroy_all
  end

  def fetch_album(fb_album)
    # Didn't find how to pass #fields to fb_album.cover_photo, so have to do like this.
    # Need some time to research and analyze how to optimize this
    fb_album_cover = FbGraph2::Photo.new(fb_album.cover_photo['id']).authenticate(@user.oauth_token).fetch(fields: 'images')

    @user.albums.create!(name: fb_album.name, description: fb_album.description, uid: fb_album.id,
                                created_time: fb_album.created_time, remote_cover_photo_url: fb_album_cover.images.first.source)
  end

  def fetch_photos(album, fb_album)
    fb_album.photos(fields: PHOTO_FIELDS).each do |fb_photo|
      album.photos.create!(name: fb_photo.name, uid: fb_photo.id, created_time: fb_album.created_time,
                          remote_image_url: fb_photo.images.first.source)
    end
  end
end
