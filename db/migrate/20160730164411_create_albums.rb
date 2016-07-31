class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.references :user, index: true, foreign_key: true
      t.string :uid
      t.string :name
      t.string :cover_photo
      t.text :description
      t.datetime :created_time

      t.timestamps null: false
    end
  end
end
