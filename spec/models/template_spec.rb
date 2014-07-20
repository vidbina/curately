require 'rails_helper'

describe Template do
  it "has elements" do
    expect(Template.new).to respond_to(:elements)
  end

  it "has a name" do
    expect(Template.new).to respond_to(:name)
  end

  it "is invalid without a name" do
    expect(build(:template, name: nil)).to be_invalid
  end

  it "is is not saved without a name" do
    expect{
      create(:template, name: nil)
    }.to raise_error
  end

  describe "with elements" do
    let(:template) { create(:template) }

    before(:each) do
      3.times { create(:element, template: template) }
    end

    it "knows its elements" do
      expect {
        2.times { create(:element, template: template) }
      }.to change(template.elements, :count).by(2)
    end

    it "has removable elements" do
      expect{
        3.times { template.elements.sample.destroy }
      }.to change(template.elements, :count).by(-3)
    end
  end
end
