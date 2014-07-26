require 'rails_helper'

describe "curators/show" do
  before(:context) do
    Template.destroy_all
  end

  before(:each) do
    @curator = assign(:curator, stub_model(Curator,
      :name => "Name"
    ))
  end

  it "renders attributes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Shortname/)
  end

  it "renders template if applicable" do
    @curator.template = create(:template)

    render
    expect(rendered).to match(/Template/)
  end
end
