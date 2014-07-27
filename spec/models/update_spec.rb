require 'rails_helper'

describe Update do
  let(:board)   { create(:board) }

  before(:each) do
    create(:element, template: board.curator.template, name: 'First thing')
    create(:element, template: board.curator.template, name: 'Second thing')
    create(:element, template: board.curator.template, name: 'Third thing')
  end

  it "needs at least one field set to be valid" do
    expect(board.updates.new()).to be_invalid
  end

  it "is invalid if a unknown field is set" do
    expect(board.updates.new(fourth_thing: 'hello', third_thing: 'ha')).to be_invalid
  end

  it "is valid if some elements are set" do
    expect(board.updates.new(first_thing: 'test')).to be_valid
  end

  it "is persisted when valid" do
    expect(board.updates.create(first_thing: 12, second_thing: 23)).to be_persisted
  end
end
