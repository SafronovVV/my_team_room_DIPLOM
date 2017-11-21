class TasksController < ApplicationController

  before_action :find_task, only: [:edit, :update]
  before_action :find_comments, :new_comment, only: :edit

  def new
    @task = current_user.tasks.new
  end

  def create
    @task = current_user.tasks.new(task_params)
    @task.team_id = current_user.team.id
    if @task.save
      redirect_to tasks_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update_attributes(update_params)
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def index
    @tasks = current_user.team.tasks.where.not(status: :closed).order('priority DESC')
  end

  private

  def find_task
    @task = Task.find(params[:id])
  end

  def update_params
    task_params.except(:task_type)
  end

  def task_params
    params.require(:task).permit(:name, :description, :status, :priority, :task_type, :user_id, :team_id)
  end

  def find_comments
    @comments = @task.comments
  end

  def new_comment
    @comment = @comments.new
  end
end
