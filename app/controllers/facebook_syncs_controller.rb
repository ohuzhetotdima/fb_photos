class FacebookSyncsController < ApplicationController
  before_filter :check_user

  def create
    SyncWorker.perform_async(current_user.id)
    redirect_to root_path, notice: 'Synchronization started'
  end
end