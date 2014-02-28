class Todo < ActiveRecord::Base
  attr_accessible :title, :body, :list_name, :todo_count, :status

  lookup = { :incomplete => 0,
             :complete => 1,
             :in_progress => 2,
             :moved => 3,
             :deleted => 4,
             :postponed => 5,
             :important => 6
            } 

  def initialize
    self.lookup.each do |key, value|
      define_method("#{key}?") do
        self.status == value
      end

      define_method("#{key}!") do
        self.update_attributes :status => value
      end

      class << self
        define_singleton_method("all_#{key}") do
          self.where(status: value)
        end

        define_singleton_method("create_by_#{key}") do
          self.create(status: value)
        end

      end
    end
  end

  # def incomplete?
  #   self.status == 0
  # end

  # def complete?
  #   self.status == 1
  # end

  # def in_progress?
  #   self.status == 2
  # end

  # def moved?
  #   self.status == 3
  # end

  # def deleted?
  #   self.status == 4
  # end

  # def postponed?
  #   self.status == 5
  # end

  # def important?
  #   self.status == 6
  # end

  # def incomplete!
  #   self.update_attributes :status => 0
  # end

  # def complete!
  #   self.update_attributes :status => 1
  # end

  # def in_progress!
  #   self.update_attributes :status => 2
  # end

  # def moved!
  #   self.update_attributes :status => 3
  # end

  # def deleted!
  #   self.update_attributes :status => 4
  # end

  # def postponed!
  #   self.update_attributes :status => 5
  # end

  # def important!
  #   self.update_attributes :status => 6
  # end

  # class << self
  #   def all_incomplete
  #     self.where :status => 0
  #   end

  #   def all_complete
  #     self.where :status => 1
  #   end

  #   def all_in_progress
  #     self.where :status => 2
  #   end

  #   def all_moved
  #     self.where :status => 3
  #   end

  #   def all_deleted
  #     self.where :status => 4
  #   end

  #   def all_postponed
  #     self.where :status => 5
  #   end

  #   def all_important
  #     self.where :status => 6
  #   end

  #   def create_by_incomplete
  #     self.create :status => 0
  #   end

  #   def create_by_complete
  #     self.create :status => 1
  #   end

  #   def create_by_in_progress
  #     self.create :status => 2
  #   end

  #   def create_by_moved
  #     self.create :status => 3
  #   end

  #   def create_by_deleted
  #     self.create :status => 4
  #   end

  #   def create_by_postponed
  #     self.create :status => 5
  #   end

  #   def create_by_important
  #     self.create :status => 6
  #   end
  # end

end
