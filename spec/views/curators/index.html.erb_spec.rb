require 'rails_helper'

describe "curators/index" do
  before(:each) do
    assign(:curators, [
      build(:curator),
      build(:curator)
    ])
  end

  it "renders a list of curators" do
    render
    assert_select "ul#curators>li", :count => 2
  end
end
