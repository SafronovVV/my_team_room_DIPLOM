class Task
  class AppointmentService
    attr_accessor :task, :last_user
    def initialize(params)
      @task = params[:task]
      @last_user = params[:last_user]
    end

    def call
      if last_user && task.appointed_to != last_user
        last_user.appointed_tasks.delete(task)
      end
      task.appointed_to.appointed_tasks << task
    end
  end
end
