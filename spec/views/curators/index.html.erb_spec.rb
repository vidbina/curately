require 'rails_helper'

describe "curators/index" do
  before(:each) do
    assign(:curators, [
      stub_model(Curator,
        :name => "Name"
      ),
      stub_model(Curator,
        :name => "Name"
      )
    ])
  end

  it "renders a list of curators" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
