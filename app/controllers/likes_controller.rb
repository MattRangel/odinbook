class LikesController < ApplicationController
  def create
    post = Post.find(like_params[:post_id])

    Like.create(post: post, user: current_user)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("post_#{post.id}_likes", partial: "posts/like_interaction", locals: {post: post})
      end
      format.html { redirect_back(fallback_location: root_path) }
    end
  end

  def like_params
    params.require(:like).permit(:post_id)
  end
end
