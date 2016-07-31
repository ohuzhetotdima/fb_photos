class CreateFacebookSyncs < ActiveRecord::Migration
  def change
    create_table :facebook_syncs do |t|
      t.references :user, index: true, foreign_key: true
      t.boolean :completed, default: false
      t.datetime :completed_at
      t.timestamps null: false
    end
  end
end
