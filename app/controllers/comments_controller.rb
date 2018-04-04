class CommentsController < ApplicationController

  def create
    @task = Task.find(params[:task_id])
    @comment = @task.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      render json: {}, status: 200
    else
      redirect_to request.referrer
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
