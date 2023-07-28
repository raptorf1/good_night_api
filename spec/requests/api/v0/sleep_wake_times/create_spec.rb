RSpec.describe "POST /api/v0/sleep_wake_times", type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe "succesfully" do
    before { post "/api/v0/sleep_wake_times", params: { user_id: user.id } }

    it "with 200 status" do
      expect(response.status).to eq 200
    end

    it "with correct message" do
      expect(
        json_response["message"]
      ).to eq "Sleep record with ID: #{SleepWakeTime.all.first.id} created successfully! Sleep time: #{SleepWakeTime.all.first.sleep}."
    end

    it "with correct number of records saved in the DB" do
      expect(SleepWakeTime.all.count).to eq 1
    end

    it "with correct user for the created record of the DB" do
      expect(SleepWakeTime.all.first.user.id).to eq user.id
    end

    it "with sleep datetime of the created record populated" do
      expect(SleepWakeTime.all.first.sleep).to_not eq nil
    end
  end

  describe "unsuccesfully" do
    describe "when user ID does not exist" do
      before { post "/api/v0/sleep_wake_times", params: { user_id: 15_000 } }

      it "with 400 status" do
        expect(response.status).to eq 400
      end

      it "with no records created in the DB" do
        expect(SleepWakeTime.all.count).to eq 0
      end

      it "with correct number of errors" do
        expect(json_response["errors"].count).to eq 1
      end

      it "with correct error message" do
        expect(json_response["errors"].first).to eq "User must exist"
      end
    end

    describe "when no user ID is passed" do
      before { post "/api/v0/sleep_wake_times" }

      it "with 400 status" do
        expect(response.status).to eq 400
      end

      it "with no records created in the DB" do
        expect(SleepWakeTime.all.count).to eq 0
      end

      it "with correct number of errors" do
        expect(json_response["errors"].count).to eq 1
      end

      it "with correct error message" do
        expect(json_response["errors"].first).to eq "You need to pass user ID!"
      end
    end
  end
end
