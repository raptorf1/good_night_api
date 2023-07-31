class Api::V0::FollowsController < ApplicationController
  def create
    existing_follow_association =
      FollowAssociation.check_follow_association_exists_before_creating(
        params[:requested_by_user_id],
        params[:user_to_follow_id]
      )
    if !existing_follow_association.nil?
      render json: {
               errors: [
                 "You already follow User with name: #{existing_follow_association.user_to_follow.name} and ID: #{existing_follow_association.user_to_follow.id}"
               ]
             },
             status: 400 and return
    end

    follow_association_to_create =
      FollowAssociation.create(
        requested_by_user_id: params[:requested_by_user_id],
        user_to_follow_id: params[:user_to_follow_id]
      )
    if !follow_association_to_create.persisted?
      render json: { errors: follow_association_to_create.errors.full_messages }, status: 400 and return
    end

    render json: {
             message:
               "You are now following User with name: #{follow_association_to_create.user_to_follow.name} and ID: #{follow_association_to_create.user_to_follow.id}",
             payload: "Association ID: #{follow_association_to_create.id}"
           },
           status: 200
  end

  def destroy
    retrieved_association = FollowAssociation.find(params[:id])
    retrieved_association.destroy

    render json: {
             message:
               "You are no longer following User with name: #{retrieved_association.user_to_follow.name} and ID: #{retrieved_association.user_to_follow.id}."
           },
           status: 200
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ["Follow association not found!"] }, status: 400
  end
end
