class User < ApplicationRecord
  has_many :sleep_wake_time, dependent: :destroy
  has_many :follow_association_1,
           class_name: "FollowAssociation",
           foreign_key: "requested_by_user_id",
           dependent: :destroy
  has_many :follow_association_2, class_name: "FollowAssociation", foreign_key: "user_to_follow_id", dependent: :destroy

  validates :name, presence: true
end
