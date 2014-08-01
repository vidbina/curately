require 'rails_helper'

describe "templates/show", :type => :view do
  before(:each) do
    @curator = stub_model(Curator, attributes_without_id(build(:curator)))
    @template = stub_model(Template, attributes_without_id(build(:template)))
  end

  it "renders the template name" do
    render

    expect(rendered).to include @template.name
  end
end
