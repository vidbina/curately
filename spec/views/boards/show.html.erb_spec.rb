require 'rails_helper'

describe "boards/show", :type => :view do
  before(:each) do
    @board = assign(:board, stub_model(Board, attributes_without_id(build(:board))))
    render
  end

  it { expect(rendered).to match(h @board.curator.name) }
  it { expect(rendered).to match(h @board.client.name) }
  it { expect(rendered).to match(h @board.template.name) }

  it { assert_select "ul#updates" }
end
