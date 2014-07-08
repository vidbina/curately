require 'spec_helper'

describe "accountants/edit" do
  before(:each) do
    @accountant = assign(:accountant, stub_model(Accountant,
      :name => "MyString"
    ))
  end

  it "renders the edit accountant form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", accountant_path(@accountant), "post" do
      assert_select "input#accountant_name[name=?]", "accountant[name]"
    end
  end
end
