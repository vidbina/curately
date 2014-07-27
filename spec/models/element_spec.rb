require 'rails_helper'

describe Element do
  it "has a name" do
    expect(Element.new).to respond_to(:name)
  end

  it "is invalid without a name" do
    expect(build(:element, name: nil)).to be_invalid
  end

  it "is is not saved without a name" do
    expect{
      create(:element, name: nil)
    }.to raise_error
  end

  it "needs a template to exist" do
    expect {
      create(:element, template: nil)
    }.to raise_error
  end

  it "can be stored" do
    expect(create(:element)).to be_persisted
  end

  it "can be updated" do
    element = create(:element)
    expect{
      element.update_attributes!({name: 'Spock'})
    }.to change(element, :name).to("Spock")
  end

  it "extracts a API fiendly key from the name" do
    expect(create(:element, name: 'Something you need').key).to eq('something_you_need')
    expect(create(:element, name: "Lucy's car").key).to eq('lucys_car')
    expect(create(:element, name: "bigDataChallenge is here").key).to eq('big_data_challenge_is_here')
  end
end
