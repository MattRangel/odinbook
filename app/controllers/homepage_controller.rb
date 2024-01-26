class HomepageController < ApplicationController
  def show
    @posts = Post.feed(current_user.feed_user_ids)
  end
end
