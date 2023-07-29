RSpec.describe User, type: :model do
  describe "Factory" do
    it "should be valid" do
      expect(create(:user)).to be_valid
    end
  end

  describe "Database table" do
    it { is_expected.to have_db_column :id }
    it { is_expected.to have_db_column :name }
    it { is_expected.to have_db_column :created_at }
    it { is_expected.to have_db_column :updated_at }
  end

  describe "Validations" do
    it { is_expected.to validate_presence_of :name }
  end

  describe "Relations" do
    it { is_expected.to have_many(:sleep_wake_time) }
  end

  describe "Delete dependent settings" do
    it "sleep record is deleted when associated user is deleted from the database" do
      FactoryBot.create(:sleep_wake_time)
      SleepWakeTime.last.user.destroy
      expect(SleepWakeTime.all.length).to eq 0
    end
  end
end
