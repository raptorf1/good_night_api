class SleepWakeTime < ApplicationRecord
  after_update :calculate_difference

  belongs_to :user

  def calculate_difference
    self.update_column(:difference, self.wake - self.sleep) if !self.sleep.nil? && !self.wake.nil?
  end

  def self.fetch_all_sorted_by_created_at
    SleepWakeTime.all.sort_by { |sleep_wake_time| sleep_wake_time.created_at }.reverse
  end
end
