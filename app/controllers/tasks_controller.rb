class TasksController < ApplicationController

  before_action :registration_completed?
  before_action :find_task, only: [:edit, :update]
  before_action :find_comments, :new_comment, only: :edit

  def new
    @task = current_user.tasks.new
  end

  def create
    @task = current_user.tasks.new(task_params)
    @task.team_id = current_user.team.id
    if @task.save
      @task.appointed_to.appointed_tasks << @task
      flash[:success] = 'Task was created!'
      redirect_to tasks_path
    else
      flash[:error] = record_errors(@task)
      render :new
    end
  end

  def edit
    @comments = @comments.order('created_at DESC')
  end

  def update
    @last_user = @task.appointed_to
    if @task.update_attributes(update_params)
      if @task.appointed_to != @last_user
        @last_user.appointed_tasks.delete(@task)
        @task.appointed_to.appointed_tasks << @task
      end
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def index
    @q = current_user.team.tasks.where.not(status: :closed).ransack(params[:q])
    @tasks = @q.result(distinct: true)
  end

  private

  def find_task
    @task = Task.find(params[:id])
  end

  def update_params
    task_params.except(:task_type)
  end

  def task_params
    params.require(:task).permit(:name, :description, :status, :priority, :task_type, :percentage, :appointed_to_id)
  end

  def find_comments
    @comments = @task.comments
  end

  def new_comment
    @comment = @comments.new
  end
end
