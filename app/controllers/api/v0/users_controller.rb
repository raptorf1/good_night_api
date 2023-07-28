class Api::V0::UsersController < ApplicationController
  def index
    render json: { message: "Meow!" }
  end
end
