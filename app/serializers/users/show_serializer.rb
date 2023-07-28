class Users::ShowSerializer < ActiveModel::Serializer
  attributes :id, :name, :sleep_records

  def sleep_records
    SleepWakeTime.where(user_id: object.id).select(:id, :sleep, :wake, :difference)
  end
end
