require 'rails_helper'

RSpec.describe "templates/index", :type => :view do
  before(:each) do
    assign(:boards, [
      stub_model(Template, attributes_without_id(build(:template))),
      stub_model(Template, attributes_without_id(build(:template))),
      stub_model(Template, attributes_without_id(build(:template)))
    ])
  end

  it "renders a list of boards" do
    skip # we only have a single template per curator
    render

    assert_select "ul#templates>li", :count => 3
  end
end
