class Api::V0::FollowsController < ApplicationController
  def create
    existing_follow_association =
      FollowAssociation.check_follow_association_exists_before_creating(
        params[:requested_by_user_id],
        params[:user_to_follow_id]
      )
    if !existing_follow_association.nil?
      render json: {
               errors:
                 "You already follow user with name: #{existing_follow_association.user_to_follow.name} and ID: #{existing_follow_association.user_to_follow.id}"
             },
             status: 400 and return
    end

    follow_association_to_create =
      FollowAssociation.create(
        requested_by_user: params[:requested_by_user_id],
        user_to_follow: params[:user_to_follow_id]
      )
    if !follow_association_to_create.persisted?
      render json: { errors: follow_association_to_create.errors.full_messages }, status: 400 and return
    end

    render json: {
             message:
               "You are now following user with name: #{follow_association_to_create.user_to_follow.name} and ID: #{follow_association_to_create.user_to_follow.id}"
           },
           status: 200
  end
end
