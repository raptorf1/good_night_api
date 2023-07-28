class SleepWakeTimes::Serializer < ActiveModel::Serializer
  attributes :sleep, :wake, :difference

  belongs_to :user, serializer: Users::Serializer
end
