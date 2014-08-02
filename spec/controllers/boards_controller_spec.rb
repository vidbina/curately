require 'rails_helper'

describe BoardsController, :type => :controller do
  let(:curator) { create(:curator) }
  let(:client) { create(:client) }
  let(:board) { create(:board, curator: curator, client: client) }
  let(:user) { create(:user) }
  let(:curatorship) { create(:curatorship, user: user, curator: curator) }
  let(:membership) { create(:membership, user: user, client: client) }

  before(:each) {
    Board.destroy_all
    create(:element, name: 'revenue',   template: curator.template)
    create(:element, name: 'costs',  template: curator.template)
    create(:element, name: 'profit', template: curator.template)
    sign_in :user, curatorship.user
  }

  let(:valid_attributes) {
    {
      curator: { id: curator.id, name: curator.name },
      client: { id: client.id, name: client.name },
    }
  }

  let(:invalid_attributes) {
    {
      curator: { id: curator.id, name: curator.name },
      client: { name: client.name },
    }
  }

  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns membership and curatorship boards as @boards" do
      1.times {
        create(:board)
      }
      2.times {
        create(:board, client: membership.client)
      }
      3.times {
        create(:board, curator: curatorship.curator)
      }
      get :index, {}, valid_session
      expect(assigns(:boards).count).to eq(5)
    end
  end

  describe "GET show" do
    it "assigns the requested board as @board" do
      get :show, {:id => board.to_param}, valid_session
      expect(assigns(:board)).to eq(board)
    end
  end

  describe "GET new" do
    it "assigns a new board as @board" do
      get :new, {}, valid_session
      expect(assigns(:board)).to be_a_new(Board)
    end
  end

  describe "GET edit" do
    it "assigns the requested board as @board" do
      get :edit, {:id => board.to_param}, valid_session
      expect(assigns(:board)).to eq(board)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Board" do
        expect {
          post :create, { board: valid_attributes }, valid_session
        }.to change(Board, :count).by(1)
      end

      it "assigns a newly created board as @board" do
        post :create, { board: valid_attributes }, valid_session
        expect(assigns(:board)).to eq(Board.last)
      end

      it "redirects to the created board" do
        post :create, { board: valid_attributes }, valid_session
        expect(response).to redirect_to(Board.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved board as @board" do
        post :create, { board: invalid_attributes }, valid_session
        expect(assigns(:board)).to be_a_new(Board)
      end

      it "re-renders the 'new' template" do
        post :create, { board: invalid_attributes }, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested board" do
        skip("Add assertions for updated state")
        put :update, {:id => board.to_param, :board => new_attributes}, valid_session
      end

      it "assigns the requested board as @board" do
        put :update, { :id => board.to_param, board: valid_attributes }, valid_session
        expect(assigns(:board)).to eq(board)
      end

      it "redirects to the board" do
        put :update, {:id => board.to_param, :board => valid_attributes}, valid_session
        expect(response).to redirect_to(board)
      end
    end

    describe "with invalid params" do
      it "assigns the board as @board" do
        put :update, { id: board.to_param, board: invalid_attributes }, valid_session
        expect(assigns(:board)).to eq(board)
      end

      it "re-renders the 'edit' template" do
        put :update, { id: board.to_param, board: invalid_attributes }, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested board" do
      expect {
        delete :destroy, {:id => board.to_param}, valid_session
      }.to change(board.class, :count).by(-1)
    end

    it "redirects to the boards list" do
      delete :destroy, {:id => board.to_param}, valid_session
      expect(response).to redirect_to(boards_url)
    end
  end

end
