class RelationshipsController < ApplicationController
  def create
    relationship = current_user.following_relationships.create(relationship_params)
    render partial: "users/follow", locals: {user: relationship.following}
  end

  def destroy
    relationship = current_user.followed_by_relationships.find_by(followed_by_id: relationship_params[:followed_by_id])
    relationship.destroy unless relationship.nil?
    render turbo_stream: turbo_stream.remove("response_user_#{relationship_params[:followed_by_id]}")
  end

  def update
    relationship = current_user.followed_by_relationships.where(relationship_params)
    relationship.update(accepted: true) unless relationship.nil?
    render turbo_stream: turbo_stream.remove("response_user_#{relationship_params[:followed_by_id]}")
  end

  def following
    @users = current_user.following_users.for_view
  end

  def followed_by
    @users = current_user.followed_by_users_accepted.for_view
  end

  def requests
    @users = current_user.followed_by_users_pending.for_view
  end

  private
  def relationship_params
    params.require(:relationship).permit(:following_id, :followed_by_id)
  end
end
