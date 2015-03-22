class AddUserRefToPics < ActiveRecord::Migration
  def change
    add_reference :pics, :user, index: true
    add_foreign_key :pics, :users
  end
end
