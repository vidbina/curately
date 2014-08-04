require 'rails_helper'

describe "updates/show", :type => :view do
  before(:each) do
    @board  = assign(:board, stub_model(Board, attributes_without_id(build(:board))))
    @update = assign(:update, stub_model(Update, attributes_without_id(build(:update))))
    allow(@update).to receive(:board).and_return(@board)
    allow(@update).to receive(:elements).and_return([])
    render
  end

  it "renders attributes in <p>" do
    expect(rendered).to include(@update.time.to_s)
  end

  #it { expect(rendered).to match
end
