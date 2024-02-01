class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = Post.feed(@user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    current_user.update(name_param)
    redirect_to user_path
  end

  private
  def name_param
    params.require(:user).permit(:name)
  end
end
