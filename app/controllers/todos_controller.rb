class TodosController < ApplicationController

  def index
    @todos = Todo.all
    @todo_lists = Todo.pluck(:list_name).uniq 
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
    @todo = Todo.new params[:todo]
    @todo.list_name = slugify_list(list_name)
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
    @todo.list_name = slugify_list(params[:todo].delete(:list_name))
    if @todo.update_attributes params[:todo]
      redirect_to @todo
    else
      render :edit
    end
  end

  private

  def slugify_list(list_name)
    list_name.downcase.gsub ' ', '-'
  end
end
