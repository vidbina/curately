require 'rails_helper'

describe "templates/edit", :type => :view do
  before(:each) do
    @curator = stub_model(Curator, attributes_without_id(build(:curator)))
    @template = stub_model(Template, elements: [
      stub_model(Element, attributes_without_id(build(:element, name: 'Metric one'))),
      stub_model(Element, attributes_without_id(build(:element, name: 'Two')))
    ])
  end

  it "renders the edit board form" do
    render

    assert_select "form[action=?][method=?]", curator_template_path(@curator), "post" do
      assert_select "input#template_name[name=?]", "template[name]"
      #assert_select "input#template_metric_one[name=?]", "template[metric_one]"
      #assert_select "input#template_two[name=?]", "template[two]"
    end
  end
end
