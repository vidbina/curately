require 'rails_helper'

RSpec.describe "Updates", :type => :request do
  describe "GET /updates" do
    it "works! (now write some real specs)" do
      get updates_path
      expect(response.status).to be(200)
    end
  end
end
