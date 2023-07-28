class ChangeBigintToFlotInSleepWakeTime < ActiveRecord::Migration[5.2]
  def change
    change_column :sleep_wake_times, :difference, :float
  end
end
