class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :album, index: true, foreign_key: true
      t.string :uid
      t.text :name
      t.string :image
      t.datetime :created_time

      t.timestamps null: false
    end
  end
end
