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
end
