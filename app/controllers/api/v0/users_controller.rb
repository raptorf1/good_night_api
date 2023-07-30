class Api::V0::UsersController < ApplicationController
  def index
    render json: {
             payload: ActiveModelSerializers::SerializableResource.new(User.all, each_serializer: Users::Serializer)
           },
           status: 200
  end

  def show
    retrieved_user = User.find(params[:id])

    render json: {
             payload:
               ActiveModelSerializers::SerializableResource.new(retrieved_user, serializer: Users::ShowSerializer)
           },
           status: 200
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ["User not found!"] }, status: 400
  end

  def create
    user_to_create = User.create(name: params[:name])
    render json: { errors: user_to_create.errors.full_messages }, status: 400 and return if !user_to_create.persisted?

    render json: {
             message: "User created successfully! Name: #{user_to_create.name}, ID: #{user_to_create.id}",
             payload: ActiveModelSerializers::SerializableResource.new(user_to_create, serializer: Users::Serializer)
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
