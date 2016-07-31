class ChangeSyncCompletionLogic < ActiveRecord::Migration
  def change
    remove_column :facebook_syncs, :completed
    remove_column :facebook_syncs, :completed_at

    add_column :facebook_syncs, :status, :integer, default: 0
    add_column :facebook_syncs, :finished_at, :datetime
  end
end
