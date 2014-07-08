require 'spec_helper'

describe "accountants/new" do
  before(:each) do
    assign(:accountant, stub_model(Accountant,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new accountant form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", accountants_path, "post" do
      assert_select "input#accountant_name[name=?]", "accountant[name]"
    end
  end
end
