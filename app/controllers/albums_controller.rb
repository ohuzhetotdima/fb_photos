class AlbumsController < ApplicationController
  before_filter :check_user

  def index
    @albums = current_user.albums.paginate(page: params[:page], per_page: 10)
  end

  def show
    @album  = current_user.albums.find(params[:id])
    @photos = @album.photos.paginate(page: params[:page], per_page: 20)
  end
end