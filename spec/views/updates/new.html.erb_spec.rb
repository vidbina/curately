require 'rails_helper'

describe "updates/new", :type => :view do
  before(:each) do
    @board = assign(:board, stub_model(Board, attributes_without_id(build(:board))))
    elements = [
      stub_model(Element, attributes_without_id(build(:element, name: 'Money'))),
      stub_model(Element, attributes_without_id(build(:element, name: 'The hustle'))),
    ]
    allow(@board).to receive(:elements).and_return(elements)
    @update = assign(:update, @board.updates.new())
    @update.setup_element_methods
  end

  # TODO: fix this broken test, somehow assert_select fails
  it "renders new update form" do
    render
    expect(rendered).to include("update_money")
    assert_select "form[action=?][method=?]", board_updates_path(@board), "post" do
      assert_select "input#update_money[name=?]", "update[money]"
      assert_select "input#update_the_hustle[name=?]", "update[the_hustle]"
    end
  end
end
