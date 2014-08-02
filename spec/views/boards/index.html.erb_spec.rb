require 'rails_helper'

describe "boards/index", :type => :view do
  before(:each) do
    @boards = assign(:boards, [
      stub_model(Board, attributes_without_id(build(:board))),
      stub_model(Board, attributes_without_id(build(:board)))
    ])
    render
  end

  it "renders a list of boards" do
    assert_select "ul#boards > li", count: 2
  end

  it "names the curator for each board" do
    expect(rendered).to include(*@boards.map { |b| "".html_safe << "by #{b.curator.name}" })
  end

  it "names the client for each board" do
    expect(rendered).to include(*(@boards.map { |b| "".html_safe << "#{b.client.name}'s" }))
  end

  it "names the template for each board" do
    expect(rendered).to include(*@boards.map { |b| "".html_safe << "#{b.curator.template.name}" })
  end
end
