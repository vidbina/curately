require 'rails_helper'

describe "boards/show", :type => :view do
  before(:each) do
    @board = assign(:board, create(:board))
  end

  it "renders attributes in <p>" do
    skip
    render
  end
end
