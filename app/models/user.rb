class User < ApplicationRecord
  has_many :sleep_wake_time, dependent: :destroy

  validates :name, presence: true
end
