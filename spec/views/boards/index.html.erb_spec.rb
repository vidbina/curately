require 'rails_helper'

RSpec.describe "boards/index", :type => :view do
  before(:each) do
    assign(:boards, [
      create(:board),
      create(:board)
    ])
  end

  it "renders a list of boards" do
    skip
    render
  end
end
