require 'rails_helper'

describe "boards/show", :type => :view do
  before(:each) do
    @board = assign(:board, stub_model(Board, attributes_without_id(build(:board))))
  end

  it "renders attributes in <p>" do
    skip
    render
  end
end
