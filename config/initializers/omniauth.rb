# Should be moved to secrets.yml
APP_ID = '1733648676852195'
SECRET = 'd7eb9594e069dc55791f1306992828a0'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, APP_ID, SECRET, scope: 'user_photos'
end