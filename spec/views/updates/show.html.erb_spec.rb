require 'rails_helper'

RSpec.describe "updates/show", :type => :view do
  before(:each) do
    @board  = assign(:board, stub_model(Board, attributes_without_id(build(:board))))
    @update = assign(:update, stub_model(Update, attributes_without_id(build(:update))))
  end

  it "renders attributes in <p>" do
    render

    expect(rendered).to include(@update.time.to_s)
  end
end
