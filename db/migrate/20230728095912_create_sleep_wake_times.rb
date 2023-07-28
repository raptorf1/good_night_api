class CreateSleepWakeTimes < ActiveRecord::Migration[5.2]
  def change
    create_table :sleep_wake_times do |t|
      t.datetime :sleep
      t.datetime :wake
      t.bigint :difference
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
