class AddDefaultToIsCompletedInTasks < ActiveRecord::Migration[8.0]
  def change
    change_column_default :tasks, :is_completed, from: nil, to: false
  end
end
