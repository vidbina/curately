require 'spec_helper'

describe "accountants/index" do
  before(:each) do
    assign(:accountants, [
      stub_model(Accountant,
        :name => "Name"
      ),
      stub_model(Accountant,
        :name => "Name"
      )
    ])
  end

  it "renders a list of accountants" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
