require 'rails_helper'

describe "Curators" do
  let(:user) {
    User.create(email: 'yoda@jedi.org', password: 'Entry, I request')
  }

#  describe "GET /curators" do
#    it "returns all curators when logged in" do
#      sign_in :user, user
#      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
#      get curators_path
#      response.status.should be(200)
#    end
#  end
end
