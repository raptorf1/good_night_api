RSpec.describe "POST /api/v0/follows", type: :request do
  let(:user_requesting_follow) { FactoryBot.create(:user) }
  let(:user_to_follow) { FactoryBot.create(:user) }

  describe "succesfully" do
    before do
      post "/api/v0/follows",
           params: {
             requested_by_user_id: user_requesting_follow.id,
             user_to_follow_id: user_to_follow.id
           }
    end

    it "with 200 status" do
      expect(response.status).to eq 200
    end

    it "with correct number of results saved in the DB" do
      expect(FollowAssociation.all.count).to eq 1
    end

    it "with correct attributes of result saved in the DB" do
      expect(FollowAssociation.all.first.requested_by_user.id).to eq user_requesting_follow.id
      expect(FollowAssociation.all.first.user_to_follow.id).to eq user_to_follow.id
    end

    it "with correct message returned" do
      expect(
        json_response["message"]
      ).to eq "You are now following user with name: #{user_to_follow.name} and ID: #{user_to_follow.id}"
    end
  end

  describe "unsuccesfully" do
    describe "when no params are passed" do
      before { post "/api/v0/follows" }

      it "with 400 status" do
        expect(response.status).to eq 400
      end

      it "with correct number of error messages" do
        expect(json_response["errors"].count).to eq 2
      end

      it "with correct error message" do
        expect(json_response["errors"].first).to eq "Requested by user must exist"
      end

      it "with correct error message" do
        expect(json_response["errors"].second).to eq "User to follow must exist"
      end

      it "with no record created in the DB" do
        expect(FollowAssociation.all.count).to eq 0
      end
    end

    describe "when params are passed with users that do not exist" do
      before { post "/api/v0/follows", params: { requested_by_user_id: 10_000, user_to_follow_id: 15_000 } }

      it "with 400 status" do
        expect(response.status).to eq 400
      end

      it "with correct number of error messages" do
        expect(json_response["errors"].count).to eq 2
      end

      it "with correct error message" do
        expect(json_response["errors"].first).to eq "Requested by user must exist"
      end

      it "with correct error message" do
        expect(json_response["errors"].second).to eq "User to follow must exist"
      end

      it "with no record created in the DB" do
        expect(FollowAssociation.all.count).to eq 0
      end
    end

    describe "when association between the users already exists" do
      before do
        FactoryBot.create(
          :follow_association,
          requested_by_user_id: user_requesting_follow.id,
          user_to_follow_id: user_to_follow.id
        )

        post "/api/v0/follows",
             params: {
               requested_by_user_id: user_requesting_follow.id,
               user_to_follow_id: user_to_follow.id
             }
      end

      it "with 400 status" do
        expect(response.status).to eq 400
      end

      it "with correct number of error messages" do
        expect(json_response["errors"].count).to eq 1
      end

      it "with correct error message" do
        expect(
          json_response["errors"].first
        ).to eq "You already follow user with name: #{user_to_follow.name} and ID: #{user_to_follow.id}"
      end

      it "with no extra record created in the DB" do
        expect(FollowAssociation.all.count).to eq 1
      end
    end
  end
end
