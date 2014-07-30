require 'rails_helper'

describe "updates/index", :type => :view do
  before(:each) do
    assign(:board, stub_model(Board))
    assign(:updates, [
      stub_model(Update, attributes_without_id(build(:update))),
      stub_model(Update, attributes_without_id(build(:update))),
      stub_model(Update, attributes_without_id(build(:update))),
      stub_model(Update, attributes_without_id(build(:update)))
    ])
  end

  before(:each) do
    render
  end

  it "renders a list of updates" do
    assert_select "ul#updates>li", count: 4
  end
end
