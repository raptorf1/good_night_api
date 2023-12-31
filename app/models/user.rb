class User < ApplicationRecord
  has_many :sleep_wake_time, dependent: :destroy
  has_many :follow_association_1,
           class_name: "FollowAssociation",
           foreign_key: "requested_by_user_id",
           dependent: :destroy
  has_many :follow_association_2, class_name: "FollowAssociation", foreign_key: "user_to_follow_id", dependent: :destroy

  validates :name, presence: true

  def self.one_week_sleep_records_of_user_and_following_sorted_by_difference(user_id)
    users_ids_of_sleep_records_to_retrieve = [user_id]

    existing_associations = FollowAssociation.where(requested_by_user_id: user_id).select(:user_to_follow_id)
    if !existing_associations.empty?
      users_ids_of_sleep_records_to_retrieve.push(existing_associations.map(&:user_to_follow_id))
    end

    SleepWakeTime
      .where(
        user_id: users_ids_of_sleep_records_to_retrieve.flatten,
        wake: DateTime.now.utc - 2.weeks..DateTime.now.utc - 1.week
      )
      .where.not(difference: nil)
      .sort_by(&:difference)
      .reverse
  end
end
