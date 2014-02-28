class TodosController < ApplicationController
  before_save :update_todo_list_count

  def index
    @todos = Todo.all
    @todo_lists = @todos.pluck(:list_name).uniq 
    # @todo_lists = Todo.all.map(&:list_name).uniq

  end

  def new
    @todo = Todo.new
  end

  def show
    @todo = Todo.find params[:id]
  end

  def create
    list_name = params[:todo].delete(:list_name)
    list_name = slugify_list(list_name)
    @todo = Todo.new params[:todo]
    @todo.list_name = list_name
    if @todo.save
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
    @todo = Todo.find params[:id]
  end

  def update
    @todo = Todo.find params[:id]
    list_name = params[:todo].delete(:list_name)
    list_name = slugify_list(list_name)
    @todo.list_name = list_name
    if @todo.save
      redirect_to @todo
    else
      render :edit
    end
  end

  private

  def update_todo_list_count
    todos = Todo.where :list_name => list_name
    todos.each do |todo|
      todo.update_attributes :todo_count => todos.count
      todo.save
    end
  end
    
  def slugify_list(list_name)
    list_name.downcase.gsub ' ', '-'
  end
end
