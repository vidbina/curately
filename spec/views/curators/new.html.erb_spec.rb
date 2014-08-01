require 'rails_helper'

describe "curators/new" do
  before(:each) do
    assign(
      :curator, 
      stub_model(Curator, attributes_without_id(build(:curator))).as_new_record
    )
  end

  it "renders new curator form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", curators_path, "post" do
      assert_select "input#curator_name[name=?]", "curator[name]"
    end
  end
end
