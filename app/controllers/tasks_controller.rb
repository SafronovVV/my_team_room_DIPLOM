class TasksController < ApplicationController

  before_action :find_task, only: [:edit, :update]

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @task.update_attributes(update_params)
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def index
    @tasks = Task.all.order('priority DESC')
  end

  private

  def find_task
    @task = Task.find(params[:id])
  end

  def update_params
    task_params.except(:task_type)
  end

  def task_params
    params.require(:task).permit(:name, :description, :status, :priority, :task_type)
  end
end
