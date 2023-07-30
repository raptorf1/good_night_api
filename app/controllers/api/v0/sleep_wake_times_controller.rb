class Api::V0::SleepWakeTimesController < ApplicationController
  def index
    render json: SleepWakeTime.fetch_all_sorted_by_created_at, each_serializer: SleepWakeTimes::Serializer, status: 200
  end

  def create
    record_to_create = SleepWakeTime.create(user_id: params[:user_id], sleep: Time.now)
    if !record_to_create.persisted?
      render json: { errors: record_to_create.errors.full_messages }, status: 400 and return
    end

    render json: {
             message:
               "Sleep record with ID: #{record_to_create.id} created successfully! Sleep time: #{record_to_create.sleep}."
           },
           status: 200
  end

  def update
    record_to_update = SleepWakeTime.find(params[:id])
    if !record_to_update.wake.nil?
      render json: { errors: ["Wake time is already recorded on this record. Cannot update!"] }, status: 400 and return
    end

    render json: { errors: ["You need to pass user ID!"] }, status: 400 and return if params[:user_id].nil?

    user = User.find_by(id: params[:user_id])
    render json: { errors: ["User not found!"] }, status: 400 and return if user.nil?

    if record_to_update.user.id != user.id
      render json: { errors: ["Cannot update sleep record of another user!"] }, status: 400 and return
    end

    record_to_update.update(wake: Time.now)

    if record_to_update.errors.full_messages.length > 0
      render json: { errors: record_to_update.errors.full_messages }, status: 400 and return
    end

    render json: {
             message:
               "Sleep record with ID: #{params[:id]} updated successfully! Total sleep time: #{record_to_update.difference} seconds."
           },
           status: 200
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ["Sleep record not found!"] }, status: 400
  end
end
