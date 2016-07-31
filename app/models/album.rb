class Album < ActiveRecord::Base
  belongs_to :user
  has_many :photos, dependent: :destroy

  mount_uploader :cover_photo, ImageUploader

  validates :user, :name, :cover_photo, presence: true
end
