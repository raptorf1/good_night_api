class Api::V0::SleepWakeTimesController < ApplicationController
  def index
    render json: SleepWakeTime.fetch_all_sorted_by_created_at, each_serializer: SleepWakeTimes::Serializer, status: 200
  end

  def create
    render json: { errors: ["You need to pass user ID!"] }, status: 400 and return if params[:user_id].nil?

    record_to_create = SleepWakeTime.create(user_id: params[:user_id], sleep: Time.now)
    if !record_to_create.persisted?
      render json: { errors: record_to_create.errors.full_messages }, status: 400 and return
    end

    render json: { message: "Success!" }, status: 200
  end
end
