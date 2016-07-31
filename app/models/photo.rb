class Photo < ActiveRecord::Base
  belongs_to :album

  mount_uploader :image, ImageUploader

  validates :album, :image, presence: true
end
