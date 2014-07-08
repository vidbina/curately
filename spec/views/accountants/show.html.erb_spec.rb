require 'spec_helper'

describe "accountants/show" do
  before(:each) do
    @accountant = assign(:accountant, stub_model(Accountant,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
