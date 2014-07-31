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
    it "rejects unauthorized commands" do
      get boards_path
      expect(response.status).to be(403)
    end

    it "returns the boards when authorized" do
      get boards_path, { format: 'json' }, {
        'Authorization' => basic_auth(user.email, user.password)
      }
      expect(response.status).to be(200)
    end
  end
end
