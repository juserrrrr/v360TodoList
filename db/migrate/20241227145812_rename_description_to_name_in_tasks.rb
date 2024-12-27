class RenameDescriptionToNameInTasks < ActiveRecord::Migration[8.0]
  def change
    rename_column :tasks, :description, :name
  end
end
