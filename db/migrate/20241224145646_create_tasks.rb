class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.text :description
      t.boolean :is_completed
      t.references :list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
