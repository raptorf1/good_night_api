class User < ApplicationRecord
  has_many :sleep_wake_time, dependent: :destroy
  has_many :follow_association_1,
           class_name: "FollowAssociation",
           foreign_key: "requested_by_user_id",
           dependent: :destroy
  has_many :follow_association_2, class_name: "FollowAssociation", foreign_key: "user_to_follow_id", dependent: :destroy

  validates :name, presence: true

  def self.one_week_sleep_records_of_user_and_following_sorted_by_difference(user_id)
    sleep_records = []

    sleep_records.push(SleepWakeTime.where(user_id: user_id))

    existing_associations = FollowAssociation.where(requested_by_user_id: user_id).select(:user_to_follow_id)
    if !existing_associations.empty?
      existing_associations.each { |association| sleep_records.push(association.user_to_follow.sleep_wake_time) }
    end

    sleep_records
      .flatten
      .reject { |sleep_record| sleep_record.difference.nil? }
      .select { |sleep_record| sleep_record.wake.between?(DateTime.now.utc - 2.weeks, DateTime.now.utc - 1.week) }
      .sort_by { |sleep_record| sleep_record.difference }
      .reverse
  end
end
