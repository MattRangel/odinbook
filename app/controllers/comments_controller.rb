class CommentsController < ApplicationController
  def create
    comment = current_user.comments.create(comment_params)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.prepend("post_#{comment_params[:post_id]}_comments", partial: "comments/comment", locals: {comment: comment})
      end
      format.html { redirect_to root_path }
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end
end
