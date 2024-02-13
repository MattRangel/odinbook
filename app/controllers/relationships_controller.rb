class RelationshipsController < ApplicationController
  def create
    current_user.following_relationships.create(relationship_params)
    render partial: "users/follow", locals: {user_id: relationship_params[:following_id]}
  end

  def destroy
    relationship = current_user.followed_by_relationships.find_by(followed_by_id: relationship_params[:followed_by_id])
    relationship.destroy unless relationship.nil?
    render turbo_stream: turbo_stream.remove("user_#{relationship_params[:followed_by_id]}_response")
  end

  def update
    relationship = current_user.followed_by_relationships.where(relationship_params)
    relationship.update(accepted: true) unless relationship.nil?
    render turbo_stream: turbo_stream.remove("user_#{relationship_params[:followed_by_id]}_response")
  end

  def following
    @users = current_user.following_users
  end

  def followed_by
    @users = current_user.followed_by_users_accepted
  end

  def requests
    @users = current_user.followed_by_users_pending
  end

  private
  def relationship_params
    params.require(:relationship).permit(:following_id, :followed_by_id)
  end
end
