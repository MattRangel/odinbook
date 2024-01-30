class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = Post.feed(@user.id)
  end
end
