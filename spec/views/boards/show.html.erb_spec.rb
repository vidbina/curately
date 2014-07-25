require 'rails_helper'

RSpec.describe "boards/show", :type => :view do
  before(:each) do
    @board = assign(:board, Board.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
