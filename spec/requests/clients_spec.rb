require 'rails_helper'

describe "Clients" do
  let(:user) { create(:user) }
  before(:all) do
    User.destroy_all
    Client.destroy_all
  end

  describe "GET /clients" do
    it "is unauthorized when credentials are invalid" do
      get clients_path, { format: 'json' }, {
        'Authorization' => basic_auth('test', 'test')
      }
      expect(response.status).to be(401)
    end

    it "is authorized when credentials are valid" do
      get clients_path, { format: 'json' }, {
        'Authorization' => basic_auth(user.email, user.password)
      }
      expect(response.status).to be(200)
    end
  end
end
