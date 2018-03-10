class Task
  class CreateService
    attr_accessor :task, :user
    def initialize(params)
      @task = params[:task]
      @user = params[:user]
    end

    def call
      task.team = user.team
      task.save
      if task.parent_task
        Task.find(task.parent_task_id).subtasks << task
      end
      Task::AppointmentService.new({task: task}).call
    end
  end
end
