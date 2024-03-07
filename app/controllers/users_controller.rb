class UsersController < ApplicationController
  def show
    @user = User.for_view.find(params[:id])
    @posts = Post.feed(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    current_user.update(user_params)
    user.avatar.attach(params[:avatar_image]) unless params[:avatar_image].nil?
    redirect_to edit_user_path
  end

  def index
    @users = User.all.includes(:followed_by_relationships).for_view
  end

  private
  def user_params
    params.require(:user).permit(:name, :bio, :avatar_image)
  end
end
