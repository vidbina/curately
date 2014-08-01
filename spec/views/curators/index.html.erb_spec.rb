require 'rails_helper'

describe "curators/index" do
  before(:each) do
    assign(:curators, [
      stub_model(Curator, attributes_without_id(build(:curator))),
      stub_model(Curator, attributes_without_id(build(:curator)))
    ])
  end

  it "renders a list of curators" do
    render
    assert_select "ul#curators>li", :count => 2
  end
end
