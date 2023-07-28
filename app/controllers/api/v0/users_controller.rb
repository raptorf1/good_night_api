class Api::V0::UsersController < ApplicationController
  def index
    render json: User.all, each_serializer: Users::Serializer, status: 200
  end
end
