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

  describe "with specified fields" do
    let(:curator) { create(:curator) }

    before(:example) do
      create(:element, name: 'size', template: curator.template)
      create(:element, name: 'ratio', template: curator.template)
    end

    it "knows its allowed elements" do
      expect(create(:board, curator: curator).send(:elements)).to match(curator.template.elements)
    end
  
    it "stores the supplied content" do
      expect(create(:board, curator: curator, content: { size: 12, ratio: 0.5 }).content).to include(
        size: 12
      )
    end

    it "ignores elements not included in the template" do
      expect(create(:board, curator: curator, content: { size: 32, blah: 'ha' }).content).not_to include(
        :blah
      )
    end

    it "updates the supplied content" do
      board = create(:board, curator: curator, content: { size: 12 })
      board.content = { size: 24 }
      expect(board.content).to include(size: 24)
    end

    it "adds a new transaction upon update" do
      board = create(:board, curator: curator, content: { size: 92 })
      expect{ 
        board.content = { size: 24 }
      }.to change{ 
        board.history.length 
      }.by(1)
    end
  
    it "appends modifications with a timestamp" do
      board = create(:board, curator: curator, content: { size: 43 })
      board.content = { size: 44 }
      expect(board.history.first).to include(:_timestamp)
    end
  end
end
