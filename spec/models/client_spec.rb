require 'spec_helper'

describe Client do
  let(:attributes) { {
    name: 'Starfleet Enterprises',
    shortname: 'starfleetent',
    data: '{"starship classes": "61"}'
  } }

  before(:all) do
    puts Client.destroy_all
  end

  it "has an UUID" do
    client = Client.create!(attributes)
    UUIDTools::UUID.parse(client.id.to_s)
  end

  it "fails when object with similar shortname already exists" do
    Client.create!(attributes).new_record?.should eq(false)
    expect { 
      Client.create!(attributes) #.new_record?.should eq(true)
    }.to raise_error
  end

  it "fails when shortname is nil" do
    attributes[:shortname] = nil
    Client.create(attributes).new_record?.should eq true
  end

  it "fails when shortname is empty" do
    attributes[:shortname] = ''
    Client.create(attributes).new_record?.should eq true
  end

  it "fails when shortname contains more than just alphanumeric characters" do
    attributes[:shortname] = 'short trick'
    Client.create(attributes).new_record?.should eq true
  end

  it "succeeds when shortname begins with a number" do
    attributes[:shortname] = '2short'
    Client.create(attributes).new_record?.should eq false
  end

  it "fails when name is nil" do
    attributes[:name] = nil
    Client.create(attributes).new_record?.should eq true
  end

  it "fails when name is empty" do
    attributes[:name] = ''
    Client.create(attributes).new_record?.should eq true
  end

  it "succeeds when only the shortname differs from a existing client" do
    Client.create!(attributes).new_record?.should eq(false)
    attributes[:shortname] = 'strflt'
    Client.create!(attributes).new_record?.should eq(false)
  end
end
