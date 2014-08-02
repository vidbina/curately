require 'rails_helper'

describe "elements/index.html.erb", :type => :view do
  before(:each) do
    assign(:curator, stub_model(Curator, attributes_without_id(build(:curator))))
    assign(:elements, 4.times.map { 
      stub_model(Element, attributes_without_id(build(:element))) 
    })
  end

  it "renders all elements"
end
