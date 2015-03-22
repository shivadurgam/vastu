class CreatePics < ActiveRecord::Migration
  def change
    create_table :pics do |t|
      t.string :picture

      t.timestamps null: false
    end
  end
end
