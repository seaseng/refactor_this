class RemoveTodoCountFromTodo < ActiveRecord::Migration
  def up
    remove_column :todos, :todo_count
  end

  def down
    add_column :todos, :todo_count, :integer
  end
end
