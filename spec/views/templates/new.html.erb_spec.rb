require 'rails_helper'

describe "templates/new", :type => :view do
  before(:each) do
    @curator = assign(:curator, stub_model(Curator, attributes_without_id(build(:curator))))
    assign(:template, Template.new)
  end

  it "renders new template form" do
    render

    assert_select "form[action=?][method=?]", curator_template_path(@curator), "post" do
      assert_select "input#template_name[name=?]", "template[name]"
    end
  end
end
