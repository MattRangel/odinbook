class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.for_view
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
    @users = User.all
  end

  private
  def user_params
    params.require(:user).permit(:name, :bio, :avatar_image)
  end
end
