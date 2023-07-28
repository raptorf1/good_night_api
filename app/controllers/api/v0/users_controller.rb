class Api::V0::UsersController < ApplicationController
  def index
    render json: User.all, each_serializer: Users::Serializer, status: 200
  end

  def show
    retrieved_user = User.find(params[:id])

    render json: retrieved_user, serializer: Users::ShowSerializer, status: 200
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ["User not found!"] }, status: 400
  end
end
