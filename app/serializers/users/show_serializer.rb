class Users::ShowSerializer < ActiveModel::Serializer
  attributes :id, :name, :sleep_records

  def sleep_records
    ActiveModelSerializers::SerializableResource.new(
      User.one_week_sleep_records_of_user_and_following_sorted_by_difference(object.id),
      each_serializer: SleepWakeTimes::Serializer
    )
  end
end
