class AddForeignKeyToLists < ActiveRecord::Migration[8.0]
  def change
    add_foreign_key :lists, :users
  end
end