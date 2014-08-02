require 'rails_helper'

describe "elements/new.html.erb", :type => :view do
  before(:each) do
    @curator = assign(:curator, stub_model(Curator, attributes_without_id(build(:curator))))
    @template = assign(:template, @curator.template)
    @element = assign(:element, @curator.template.elements.new)
  end

  it "renders the name input field in the form" do
    render
    assert_select "form[action=?][method=?]", curator_template_elements_path(curator_id: @curator.id), "post" do
      assert_select "input#element_name[name=?]", "element[name]"
    end
  end
end
