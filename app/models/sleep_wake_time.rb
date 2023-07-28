class SleepWakeTime < ApplicationRecord
  after_update :calculate_difference

  belongs_to :user

  def calculate_difference
    if !self.sleep.nil? && !self.wake.nil?
      self.update_column(:difference, self.wake - self.sleep)
    end
  end
end
