class RelationshipsController < ApplicationController
  def create
    current_user.following_relationships.create(relationship_params)
    render partial: "users/follow", locals: {user_id: relationship_params[:following_id]}
  end

  private
  def relationship_params
    params.require(:relationship).permit(:following_id)
  end
end
