require 'rails_helper'

describe Curator do
  let(:valid_attributes) { {
    name: 'ABCTotaal Almere',
    shortname: 'abctotaal',
  } }

  let(:curator) { create(:curator) }

  before(:all) do
    Curator.destroy_all
  end

  it "has a UUID" do
    curator = Curator.create!(valid_attributes)
    UUIDTools::UUID.parse(curator.id.to_s)
  end

  it "may have a template" do
    expect(Curator.new).to respond_to(:template)
  end

  it "knows how to retrieve its related template" do
    template = create(:template)
    c = create(:curator, template: template)
    expect(Curator.find(c.id).template).to eq(template)
  end

  it "knows its users" do
    expect {
      2.times { create(:curatorship, curator: curator) }
    }.to change(curator.users, :count).by(2)
  end

  it "fails when shortname is already taken" do
    expect(Curator.create!(valid_attributes)).to be_persisted
    expect { 
      Curator.create!(valid_attributes)
    }.to raise_error
  end

  it "fails when shortname is nil" do
    valid_attributes[:shortname] = nil
    expect(Curator.create(valid_attributes)).not_to be_persisted
  end

  it "fails when shortname is empty" do
    valid_attributes[:shortname] = ''
    expect(Curator.create(valid_attributes)).not_to be_persisted
  end

  it "fails when shortname contains more than just alphanumeric characters" do
    valid_attributes[:shortname] = 'short trick'
    expect(Curator.create(valid_attributes)).not_to be_persisted
  end

  it "fails when shortname begins with a number" do
    valid_attributes[:shortname] = '2short'
    expect(Curator.create(valid_attributes)).not_to be_persisted
  end

  it "fails when name is nil" do
    valid_attributes[:name] = nil
    expect(Curator.create(valid_attributes)).not_to be_persisted
  end

  it "fails when name is empty" do
    valid_attributes[:name] = ''
    expect(Curator.create(valid_attributes)).not_to be_persisted
  end

  describe "available for curatorship" do
    before(:each) do
      @curator = create(:curator)
    end

    it "should be aware of related curatorships" do
      expect{
        create(:curatorship, curator: @curator)
      }.to change(@curator.curatorships, :count).by(1)
    end

    it "should accept other curatorships" do
      expect {
        @curator.curatorships << build(:curatorship)
      }.to change(Curatorship, :count).by(1)
    end

    it "removes related curatorships upon curator removal" do
      count = rand(1..10)
      count.times { create(:curatorship, curator: @curator) }
      expect {
        @curator.destroy
      }.to change(Curatorship, :count).by(-count)
    end
  end

  it "may have clients" do
    expect(Curator.new).to respond_to(:clients)
  end

  it "remembers its clients" do
    curator = Curator.create(valid_attributes)
    expect {
      curator.clients << build(:client)
    }.to change(curator.clients, :length).by(1)
  end
end
