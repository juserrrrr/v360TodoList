class ChangeNameColumnTypeInTasks < ActiveRecord::Migration[8.0]
  def up
    change_column :tasks, :name, :string
  end

  def down
    change_column :tasks, :name, :text
  end
end
