require 'rails_helper'

describe "boards/edit", :type => :view do
  before(:each) do
    # TODO: stub models
    @board = create(:board)
    create(:element, name: 'metric1', template: @board.curator.template)
    create(:element, name: 'metric2', template: @board.curator.template)
  end

  after(:all) do
    Board.destroy_all
    Curator.destroy_all
    Template.destroy_all
  end

  it "renders the edit board form" do
    render
    assert_select "form[action=?][method=?]", board_path(@board), "post"
  end
end
