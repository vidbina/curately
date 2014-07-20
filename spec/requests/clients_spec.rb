require 'rails_helper'

describe "Clients" do
  before(:all) do
    Client.destroy
  end

  describe "GET /clients" do
    it "is available to anyone" do
      get clients_path
      response.status.should be(200)
    end
  end
end
