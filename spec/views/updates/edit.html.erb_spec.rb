require 'rails_helper'

describe "updates/edit", :type => :view do
  before(:each) do
    @board = assign(:board, stub_model(Board, attributes_without_id(build(:board))))
    elements = [
      stub_model(Element, attributes_without_id(build(:element, name: 'Information'))),
      stub_model(Element, attributes_without_id(build(:element, name: 'Test run'))),
      stub_model(Element, attributes_without_id(build(:element, name: 'Valid'))),
      stub_model(Element, attributes_without_id(build(:element, name: '3 kings')))
    ]
    allow(@board).to receive(:elements).and_return(elements)
    @board.updates << (@update = assign(:update, stub_model(Update, attributes_without_id(build(:update)))))
    @update.setup_element_methods
  end

  it "renders the edit update form" do
    render
    assert_select "form[action=?][method=?]", board_update_path(@board, @update), "post" do
      assert_select "input#update_information[name=?]", "update[information]"
      assert_select "input#update_test_run[name=?]", "update[test_run]"
      assert_select "input#update_valid[name=?]", "update[valid]"
      assert_select "input#update_3_kings[name=?]", "update[3_kings]"
    end
  end
end
