class Todo < ActiveRecord::Base
  attr_accessible :title, :body, :list_name, :status

  @@LOOKUP = { :incomplete => 0,
             :complete => 1,
             :in_progress => 2,
             :moved => 3,
             :deleted => 4,
             :postponed => 5,
             :important => 6
            } 

  @@LOOKUP.each do |key, value|

    define_method("#{key}?") do
      self.status == value
    end

    define_method("#{key}!") do
      self.update_attributes :status => value
    end

    define_singleton_method("all_#{key}") do
      self.where(status: value)
    end

    define_singleton_method("create_by_#{key}") do
      self.create(status: value)
    end
  end

  def list_count
    todos = Todo.where :list_name => list_name
    todos.count
  end

end
