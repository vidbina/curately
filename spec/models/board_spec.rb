require 'rails_helper'

describe Board, :type => :model do
  it "belongs to a curator" do
    expect {
      create(:board, curator: nil)
    }.to raise_error
  end

  it "belongs to a client" do
    expect {
      create(:board, client: nil)
    }.to raise_error
  end

  it "rejects an update without a client" do
    board = create(:board)
    expect(board.update(client: nil)).to be(false)
  end

  it "rejects an update without a curator" do
    board = create(:board)
    expect(board.update(curator: nil)).to be(false)
  end

  it "is saved as long as it has a client and curator" do
    expect {
      board = create(:board)
    }.not_to raise_error
  end

  it "is not saved if the curator does not exist" do
    expect {
      create(:board, curator: build(:curator))
    }.to raise_error
  end

  it "is not saved if the client does not exist" do
    expect {
      create(:board, client: build(:client))
    }.to raise_error
  end

  it "returns the client upon request" do
    client = create(:client)
    expect(create(:board, client: client).client).to eq(client)
  end

  it "returns the curator upon request" do
    curator = create(:curator)
    expect(create(:board, curator: curator).curator).to eq(curator)
  end

  it "bases its available elements on the curator's template fields" do
    curator = create(:curator)
    board = create(:board, curator: curator)

    expect {
      3.times { create(:element, template: curator.template) }
    }.to change { board.reload.send(:elements).count }.by(3)
  end

  it "returns element names upon request" do
    curator = create(:curator)
    board = create(:board, curator: curator)

    create(:element, template: curator.template, name: 'First field')
    create(:element, template: curator.template, name: 'Second field')
    expect(board.reload.send(:element_names)).to match_array(['first_field', 'second_field', Board::VERSION_ID])
  end

  describe "with specified fields" do
    let(:curator) { create(:curator) }

    before(:example) do
      create(:element, name: 'Size', template: curator.template)
      create(:element, name: 'Ratio', template: curator.template)
    end

    it "knows its allowed elements" do
      expect(create(:board, curator: curator).send(:elements)).to match(curator.template.elements)
    end

    it "knows its updates" do
      board = create(:board, curator: curator)
      expect {
        3.times {
          board.updates.create(size: rand(10..100), ratio: rand(10..100))
        }
      }.to change(board.reload.updates, :count).by(3)
    end
  end
end
