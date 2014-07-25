require 'rails_helper'

RSpec.describe "boards/index", :type => :view do
  before(:each) do
    assign(:boards, [
      Board.create!(),
      Board.create!()
    ])
  end

  it "renders a list of boards" do
    render
  end
end
