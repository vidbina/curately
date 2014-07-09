require 'rails_helper'

describe Curator do
  let(:valid_attributes) { {
    name: 'ABCTotaal Almere',
    shortname: 'abctotaal',
  } }

  before(:all) do
    Curator.destroy_all
  end

  it "has a UUID" do
    curator = Curator.create!(valid_attributes)
    UUIDTools::UUID.parse(curator.id.to_s)
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
end
