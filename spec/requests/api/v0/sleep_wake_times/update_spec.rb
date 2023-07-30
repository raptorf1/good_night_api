RSpec.describe "PUT /api/v0/sleep_wake_times/:id", type: :request do
  let(:sleep_record) { FactoryBot.create(:sleep_wake_time, sleep: Time.now - 2.hours, wake: nil, difference: nil) }
  let(:random_sleep_record) do
    FactoryBot.create(:sleep_wake_time, sleep: Time.now - 2.hours, wake: nil, difference: nil)
  end
  let(:completed_sleep_record) { FactoryBot.create(:sleep_wake_time) }

  describe "succesfully" do
    before do
      put "/api/v0/sleep_wake_times/#{sleep_record.id}", params: { user_id: sleep_record.user.id }
      sleep_record.reload
    end

    it "with 200 status" do
      expect(response.status).to eq 200
    end

    it "with correct message" do
      expect(
        json_response["message"]
      ).to eq "Sleep record with ID: #{sleep_record.id} updated successfully! Total sleep time: #{sleep_record.difference} seconds."
    end

    it "with correct payload returned" do
      expect(json_response["payload"]["id"]).to eq sleep_record.id
    end

    it "with wake datetime of the updated record populated" do
      expect(sleep_record.wake).to_not eq nil
    end

    it "with difference field of the updated record populated" do
      expect(sleep_record.difference).to_not eq nil
    end
  end

  describe "unsuccesfully" do
    describe "when trying to update an already updated sleep record" do
      before { put "/api/v0/sleep_wake_times/#{completed_sleep_record.id}" }

      it "with 400 status" do
        expect(response.status).to eq 400
      end

      it "with correct number of errors" do
        expect(json_response["errors"].count).to eq 1
      end

      it "with correct error message" do
        expect(json_response["errors"].first).to eq "Wake time is already recorded on this record. Cannot update!"
      end
    end

    describe "when sleep record ID does not exist in DB" do
      before { put "/api/v0/sleep_wake_times/15000", params: { user_id: sleep_record.user.id } }

      it "with 400 status" do
        expect(response.status).to eq 400
      end

      it "with correct number of errors" do
        expect(json_response["errors"].count).to eq 1
      end

      it "with correct error message" do
        expect(json_response["errors"].first).to eq "Sleep record not found!"
      end
    end

    describe "when user ID is not passed" do
      before { put "/api/v0/sleep_wake_times/#{sleep_record.id}" }

      it "with 400 status" do
        expect(response.status).to eq 400
      end

      it "with correct number of errors" do
        expect(json_response["errors"].count).to eq 1
      end

      it "with correct error message" do
        expect(json_response["errors"].first).to eq "You need to pass user ID!"
      end
    end

    describe "when user ID does not exist in DB" do
      before { put "/api/v0/sleep_wake_times/#{sleep_record.id}", params: { user_id: 15_000 } }

      it "with 400 status" do
        expect(response.status).to eq 400
      end

      it "with correct number of errors" do
        expect(json_response["errors"].count).to eq 1
      end

      it "with correct error message" do
        expect(json_response["errors"].first).to eq "User not found!"
      end
    end

    describe "when trying to update another user's sleep record" do
      before { put "/api/v0/sleep_wake_times/#{random_sleep_record.id}", params: { user_id: sleep_record.user.id } }

      it "with 400 status" do
        expect(response.status).to eq 400
      end

      it "with correct number of errors" do
        expect(json_response["errors"].count).to eq 1
      end

      it "with correct error message" do
        expect(json_response["errors"].first).to eq "Cannot update sleep record of another user!"
      end
    end
  end
end
