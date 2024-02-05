class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = Post.feed(@user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    current_user.update(user_params)
    redirect_to user_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :bio)
  end
end
