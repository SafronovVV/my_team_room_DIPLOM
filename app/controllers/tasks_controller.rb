class TasksController < ApplicationController
  before_action :global_accessibility
  before_action :find_task, only: [:edit, :update]
  before_action :find_comments, :new_comment, only: :edit

  def new
    @task = current_user.tasks.new
  end

  def create
    @task = current_user.tasks.new(task_params)
    @user = current_user
    @create_service = Task::CreateService.new({task: @task, user: @user})
    if @create_service.call
      flash[:success] = 'Задача создана!'
      redirect_to tasks_path
    else
      flash[:error] = record_errors(@task)
      render :new
    end
  end

  def edit; end

  def update
    @last_user = @task.appointed_to
    if @task.update_attributes(update_params)
      Task::AppointmentService.new({task: @task, last_user: @last_user}).call
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def index
    @q = current_user.team.tasks.where.not(status: "Закрыта").ransack(params[:q])
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
    params.require(:task).permit(:name, :description,
                  :status, :priority, :task_type, :percentage,
                  :appointed_to_id, :parent_task_id)
  end

  def find_comments
    @comments = @task.comments.order('created_at DESC')
  end

  def new_comment
    @comment = @comments.new
  end
end
