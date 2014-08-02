require 'rails_helper'

describe "elements/show.html.erb", :type => :view do
  before(:each) do
    assign(:curator, stub_model(Curator, attributes_without_id(build(:curator))))
    @element = assign(:element, stub_model(Element, attributes_without_id(build(:element))))
  end

  it "displays the element's name" do
    render
    expect(rendered).to include(@element.name)
  end
end
