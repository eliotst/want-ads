class AddParentTaskToTasks < ActiveRecord::Migration[5.1]
  def change
    add_reference :tasks, :parent, index: true
    add_foreign_key :tasks, :tasks, column: :parent_id
  end
end
