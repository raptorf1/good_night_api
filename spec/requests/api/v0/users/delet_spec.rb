RSpec.describe "DELETE /api/v0/users/:id", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:sleep_record) { FactoryBot.create(:sleep_wake_time, user_id: user.id) }

  describe "succesfully" do
    before { delete "/api/v0/users/#{user.id}" }

    it "with 200 status" do
      expect(response.status).to eq 200
    end

    it "with correct user results in the DB" do
      expect(User.all.count).to eq 0
    end

    it "with correct relevant sleep record results in the DB" do
      expect(SleepWakeTime.all.count).to eq 0
    end

    it "with correct message returned" do
      expect(
        json_response["message"]
      ).to eq "User with name: #{user.name} and ID: #{user.id} successfully deleted along with all their sleep records."
    end
  end

  describe "unsuccesfully" do
    describe "when user is not found" do
      before { delete "/api/v0/users/15000" }

      it "with 400 status" do
        expect(response.status).to eq 400
      end

      it "with correct number of error messages" do
        expect(json_response["errors"].count).to eq 1
      end

      it "with correct error message" do
        expect(json_response["errors"].first).to eq "User not found!"
      end
    end
  end
end
