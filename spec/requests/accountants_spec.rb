require 'spec_helper'

describe "Accountants" do
  let(:user) {
    User.create(email: 'yoda@jedi.org', password: 'Entry, I request')
  }

#  describe "GET /accountants" do
#    it "returns all accountants when logged in" do
#      sign_in :user, user
#      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
#      get accountants_path
#      response.status.should be(200)
#    end
#  end
end
