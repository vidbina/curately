require 'rails_helper'

describe "curators/edit" do
  before(:each) do
    # NOTE: figure out the real difference between stub_model and factory_girl build
    @curator = assign(:curator, stub_model(Curator,
      :name => "MyString"
    ))
  end

  it "renders the edit curator form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", curator_path(@curator), "post" do
      assert_select "input#curator_name[name=?]", "curator[name]"
      assert_select "input#curator_shortname[name=?]", "curator[shortname]"
    end
  end
end
