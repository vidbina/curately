require 'rails_helper'

describe "elements/edit.html.erb", :type => :view do
  before(:each) do
    @curator = assign(:curator, stub_model(Curator, attributes_without_id(build(:curator))))
    @template = assign(:template, @curator.template)
    #assign(:element, @element = @template.elements.build(attributes_without_id(build(:element))))
    @template.elements << (@element = assign(:element, stub_model(Element, attributes_without_id(build(:element)))))
    #allow(@template).to receive(:elements).and_return([@element])
    allow(@element).to receive(:new_record?).and_return(false)
  end

  it "renders the name input field in the form" do
    render
    assert_select "form[action=?][method=?]", curator_template_element_path(curator_id: @curator.id, id: @element.id), "post" do
      assert_select "input#element_name[name=?]", "element[name]"
    end
  end
end
