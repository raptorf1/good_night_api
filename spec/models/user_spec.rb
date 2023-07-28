RSpec.describe User, type: :model do
  describe "Factory" do
    it "should be valid" do
      expect(create(:user)).to be_valid
    end
  end

  describe "Database table" do
    it { is_expected.to have_db_column :name }
  end
end
