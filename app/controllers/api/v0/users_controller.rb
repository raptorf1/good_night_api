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

  def create
    if params[:name].nil? || params[:name].strip.empty?
      render json: { errors: ["You need to provide a name in order to create a user!"] }, status: 400 and return
    end

    user_to_create = User.create(name: params[:name])
    render json: { errors: user_to_create.errors.full_messages }, status: 400 and return if !user_to_create.persisted?

    render json: {
             message: "User created successfully! Name: #{user_to_create.name}, ID: #{user_to_create.id}"
           },
           status: 200
  end

  def destroy
    retrieved_user = User.find(params[:id])
    retrieved_user.destroy

    render json: {
             message:
               "User with name: #{retrieved_user.name} and ID: #{retrieved_user.id} successfully deleted along with all their sleep records."
           },
           status: 200
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ["User not found!"] }, status: 400
  end
end
