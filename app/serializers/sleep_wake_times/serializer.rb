class SleepWakeTimes::Serializer < ActiveModel::Serializer
  attributes :id, :sleep, :wake, :difference, :created_at

  belongs_to :user, serializer: Users::Serializer
end
