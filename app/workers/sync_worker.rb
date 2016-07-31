class SyncWorker
  include Sidekiq::Worker

  def perform(user_id)
    user    = User.find(user_id)
    fb_sync = user.facebook_syncs.create!
    logger.info('------ Synchronization started ------')
    ActiveRecord::Base.transaction do
      begin
        Synchronizer.new(user).sync
        fb_sync.mark_completed!
        logger.info('------ Synchronization completed ------')
      rescue ActiveRecord::ActiveRecordError, FbGraph2::Exception => e
        fb_sync.mark_failed!
        logger.error("------ Synchronization error: #{e.class_name}: #{e} ------")
      rescue StandardError => e
        fb_sync.mark_failed!
        logger.error("------ Unknown error: #{e.class_name}: #{e} ------")
      end
    end
  end
end