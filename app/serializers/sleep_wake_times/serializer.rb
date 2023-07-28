class SleepWakeTimes::Serializer < ActiveModel::Serializer
  attributes :sleep, :wake, :difference, :created_at

  belongs_to :user, serializer: Users::Serializer
end
