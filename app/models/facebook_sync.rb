class FacebookSync < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true

  enum status: [:in_progress, :completed, :failed]

  def mark_completed!
    update!(status: :completed, finished_at: Time.now)
  end

  def mark_failed!
    update!(status: :failed, finished_at: Time.now)
  end
end
