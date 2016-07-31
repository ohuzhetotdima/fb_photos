class HomeController < ApplicationController
  def index
    @facebook_sync = current_user.facebook_syncs.last if current_user
  end
end