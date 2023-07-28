RSpec.describe "GET /api/v0/sleep_wake_times", type: :request do
  describe "succesfully" do
    describe "when no times exist in the DB" do
      before do
        get "/api/v0/sleep_wake_times"
      end
  
      it "with 200 status" do
        expect(response.status).to eq 200
      end
  
      it "with correct number of results" do
        expect(json_response.count).to eq 0
      end
    end

    describe "when times exist in the DB" do
      before do
        5.times { FactoryBot.create(:sleep_wake_time) }
        get "/api/v0/sleep_wake_times"
      end
  
      it "with 200 status" do
        expect(response.status).to eq 200
      end
  
      it "with correct number of results" do
        expect(json_response.count).to eq 5
      end

      it "with correct fields returned" do
        json_response.each do |time|
          expect(time).to include("sleep", "wake", "difference", "created_at", "user")
        end
      end
    end
  end
end
