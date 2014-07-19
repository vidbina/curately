require 'rails_helper'

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
    expect(Client.create!(attributes)).to be_persisted
    expect { 
      Client.create!(attributes) #.new_record?.should eq(true)
    }.to raise_error
  end

  it "fails when shortname is nil" do
    attributes[:shortname] = nil
    expect(Client.create(attributes)).not_to be_persisted
  end

  it "fails when shortname is empty" do
    attributes[:shortname] = ''
    expect(Client.create(attributes)).not_to be_persisted
  end

  it "fails when shortname contains more than just alphanumeric characters" do
    attributes[:shortname] = 'short trick'
    expect(Client.create(attributes)).not_to be_persisted
  end

  it "succeeds when shortname begins with a number" do
    attributes[:shortname] = '2short'
    expect(Client.create(attributes)).to be_persisted
  end

  it "fails when name is nil" do
    attributes[:name] = nil
    expect(Client.create(attributes)).not_to be_persisted
  end

  it "fails when name is empty" do
    attributes[:name] = ''
    expect(Client.create(attributes)).not_to be_persisted
  end

  it "succeeds when only the shortname differs from a existing client" do
    expect(Client.create!(attributes)).to be_persisted
    attributes[:shortname] = 'strflt'
    expect(Client.create!(attributes)).to be_persisted
  end

  it "has memberships" do
    expect(Client.new).to respond_to(:memberships)
  end

  it "has a curator" do
    expect(Client.new).to respond_to(:curator)
  end

  it "may have a curator" do
    curator = create(:curator)
    expect(client = create(:client, curator: curator)).to be_persisted
    expect(client.curator).to eq(curator)
  end

  it "is aware of the curatorships of its curator" do
    curator = create(:curator)
    client = create(:client, curator: curator)
    expect {
      curatorship = create(:curatorship, curator: curator)
    }.to change(client.curatorships, :count).by(1)
  end

  describe "available for membership" do
    before(:each) do
      @client = create(:client)
    end

    it "should be aware of related memberships" do
      expect {
        @membership = create(:membership, client: @client)
      }.to change(@client.memberships, :count).by(1)
    end

    it "should accept other memberships" do
      expect {
        @client.memberships << build(:membership)
      }.to change(Membership, :count).by(1)
    end

    it "removes related memberships upon client removal" do
      count = rand(1..10)
      count.times { create(:membership, client: @client) }
      expect {
        @client.destroy
      }.to change(Membership, :count).by(-count)
    end
  end
end
