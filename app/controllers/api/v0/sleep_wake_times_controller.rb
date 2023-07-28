class Api::V0::SleepWakeTimesController < ApplicationController
  def index
    render json: SleepWakeTime.fetch_all_sorted_by_created_at, each_serializer: SleepWakeTimes::Serializer, status: 200
  end
end
