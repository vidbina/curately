require 'rails_helper'

RSpec.describe "Boards", :type => :request do
  let(:board) { create(:board) }
  let(:user) { create(:user) }

  after(:all) do
    User.destroy_all
  end

  after(:each) do
    Board.destroy_all
  end

  describe "GET /boards" do
    it "is unauthorized when credentials are missing" do
      get boards_path, { format: 'json' }
      expect(response.status).to be(401)
    end

    it "returns the boards when authorized" do
      3.times { create(:board) }
      get boards_path, { format: 'json' }, {
        'Authorization' => basic_auth(user.email, user.password)
      }
      expect(JSON.parse(response.body).length).to eq(3)
    end
  end
end
