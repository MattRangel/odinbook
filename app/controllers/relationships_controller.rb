class RelationshipsController < ApplicationController
  def create
    current_user.following_relationships.create(relationship_params)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("user_#{relationship_params[:following_id]}_follow", partial: "users/follow", locals: {user_id: relationship_params[:following_id]})
      end
      format.html { redirect_back(fallback_location: root_path) }
    end
  end

  private
  def relationship_params
    params.require(:relationship).permit(:following_id)
  end
end
