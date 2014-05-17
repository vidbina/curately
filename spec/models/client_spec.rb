require 'spec_helper'

describe Client do
  let(:valid_attributes) { {
    name: 'Starfleet Enterprises',
    shortname: 'starfleetent',
    data: '{"starship classes": "61"}'
  } }

  before(:all) do
    puts Client.destroy_all
  end

  it "has an UUID" do
    client = Client.create!(valid_attributes)
    UUIDTools::UUID.parse(client.id.to_s)
  end

  it "fails when object with similar shortname already exists" do
    Client.create!(valid_attributes).new_record?.should eq(false)
    expect { 
      Client.create!(valid_attributes) #.new_record?.should eq(true)
    }.to raise_error
  end

  context "with incomplete information" do
    it "fails when name is invalid" do
      client = Client.create! valid_attributes
      client.new_record?.should eq false 
    end

    it "fails when short is invalid" do
      client = Client.create! valid_attributes
      client.new_record?.should eq false
    end
  end
end
