class CommentsController < ApplicationController

  def create
    @task = Task.find(params[:task_id])
    @comment = @task.comments.new(comment_params)
    if @comment.save
      redirect_to request.referrer
    else
      render 'new'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
