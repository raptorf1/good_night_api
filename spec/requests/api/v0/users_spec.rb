RSpec.describe "GET /api/v0/users", type: :request do
  describe "succesfully" do
    describe "when no users exist in the DB" do
      before do
        get "/api/v0/users"
      end
  
      it "with 200 status" do
        expect(response.status).to eq 200
      end
  
      it "with correct number of results" do
        expect(json_response.count).to eq 0
      end
    end

    describe "when users exist in the DB" do
      before do
        5.times { FactoryBot.create(:user) }
        get "/api/v0/users"
      end
  
      it "with 200 status" do
        expect(response.status).to eq 200
      end
  
      it "with correct number of results" do
        expect(json_response.count).to eq 5
      end

      it "with correct fields returned" do
        json_response.each do |user|
          expect(user).to include("id", "name")
        end
      end
    end
  end
end
