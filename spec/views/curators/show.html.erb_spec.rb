require 'rails_helper'

describe "curators/show" do
  before(:each) do
    @curator = assign(:curator, stub_model(Curator,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
