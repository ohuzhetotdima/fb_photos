class User < ActiveRecord::Base
  has_many :albums, dependent: :destroy
  has_many :facebook_syncs, dependent: :delete_all

  validates :name, :uid, :provider, presence: true

  class << self
    def from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider         = auth.provider
        user.uid              = auth.uid
        user.name             = auth.info.name
        user.oauth_token      = auth.credentials.token
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)

        user.save!
      end
    end
  end
end
