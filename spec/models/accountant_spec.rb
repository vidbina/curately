require 'rails_helper'

describe Accountant do
  let(:valid_attributes) { {
    name: 'ABCTotaal Almere',
    shortname: 'abctotaal',
  } }

  before(:all) do
    Accountant.destroy_all
  end

  it "has a UUID" do
    accountant = Accountant.create!(valid_attributes)
    UUIDTools::UUID.parse(accountant.id.to_s)
  end

  it "fails when shortname is already taken" do
    Accountant.create!(valid_attributes).new_record?.should eq false
    expect { 
      Accountant.create!(valid_attributes)
    }.to raise_error
  end

  it "fails when shortname is nil" do
    valid_attributes[:shortname] = nil
    Accountant.create(valid_attributes).new_record?.should eq true
  end

  it "fails when shortname is empty" do
    valid_attributes[:shortname] = ''
    Accountant.create(valid_attributes).new_record?.should eq true
  end

  it "fails when shortname contains more than just alphanumeric characters" do
    valid_attributes[:shortname] = 'short trick'
    Accountant.create(valid_attributes).new_record?.should eq true
  end

  it "fails when shortname begins with a number" do
    valid_attributes[:shortname] = '2short'
    Accountant.create(valid_attributes).new_record?.should eq true
  end

  it "fails when name is nil" do
    valid_attributes[:name] = nil
    Accountant.create(valid_attributes).new_record?.should eq true
  end

  it "fails when name is empty" do
    valid_attributes[:name] = ''
    Accountant.create(valid_attributes).new_record?.should eq true
  end
end
