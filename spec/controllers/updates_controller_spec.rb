require 'rails_helper'

describe UpdatesController, :type => :controller do
  let(:board) { create(:board) }
  let(:curatorship) { create(:curatorship, curator: board.curator, user: create(:user)) }

  let(:valid_attributes) {
    {
      'test_rate' => rand(1..100),
      'description' => Faker::HipsterIpsum.sentence,
    }
  }

  before(:each) { 
    board.curator.template.elements.create(name: 'Test rate')
    board.curator.template.elements.create(name: 'Description')
    sign_in :user, curatorship.user
  }


  let(:invalid_attributes) {
    {
      'test_rate' => rand(1..100),
      'nonexistent' => 'blah'
    }
  }

  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all updates as @updates" do
      update = board.updates.create valid_attributes
      get :index, { :board_id => board.to_param }, valid_session
      expect(assigns(:updates)).to eq([update])
    end
  end

  describe "GET show" do
    it "assigns the requested update as @update" do
      update = board.updates.create valid_attributes
      get :show, {:id => update.to_param, :board_id => board.to_param}, valid_session
      expect(assigns(:update)).to eq(update)
    end
  end

  describe "GET new" do
    it "assigns a new update as @update" do
      get :new, { :board_id => board.to_param }, valid_session
      expect(assigns(:update)).to be_a_new(Update)
    end
  end

  describe "GET edit" do
    it "assigns the requested update as @update" do
      update = board.updates.create valid_attributes
      get :edit, {:id => update.to_param, :board_id => board.to_param}, valid_session
      expect(assigns(:update)).to eq(update)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Update" do
        expect {
          post :create, {:update => valid_attributes, :board_id => board.to_param}, valid_session
        }.to change{board.reload.updates.count}.by(1)
      end

      it "assigns a newly created update as @update" do
        post :create, {:update => valid_attributes, :board_id => board.to_param}, valid_session
        expect(assigns(:update)).to be_a(Update)
        expect(assigns(:update)).to be_persisted
      end

      it "redirects to the created update" do
        post :create, {:update => valid_attributes, :board_id => board.to_param}, valid_session
        expect(response).to redirect_to(board_update_url(board, board.reload.updates.last))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved update as @update" do
        post :create, {:update => invalid_attributes, :board_id => board.to_param}, valid_session
        expect(assigns(:update)).to be_a_new(Update)
      end

      it "re-renders the 'new' template" do
        post :create, {:update => invalid_attributes, :board_id => board.to_param}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested update" do
        update = board.updates.create valid_attributes
        put :update, {:id => update.to_param, :board_id => board.to_param, :update => new_attributes}, valid_session
        update.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested update as @update" do
        update = board.updates.create valid_attributes
        put :update, {:id => update.to_param, :board_id => board.to_param, :update => valid_attributes}, valid_session
        expect(assigns(:update)).to eq(update)
      end

      it "redirects to the update" do
        update = board.updates.create valid_attributes
        put :update, {:id => update.to_param, :board_id => board.to_param, :update => valid_attributes}, valid_session
        expect(response).to redirect_to(board_update_url(board, update))
      end
    end

    describe "with invalid params" do
      it "assigns the update as @update" do
        update = board.updates.create valid_attributes
        put :update, {:id => update.to_param, :board_id => board.to_param, :update => invalid_attributes}, valid_session
        expect(assigns(:update)).to eq(update)
      end

      it "re-renders the 'edit' template" do
        update = board.updates.create valid_attributes
        put :update, {:id => update.to_param, :board_id => board.to_param, :update => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested update" do
      update = board.updates.create valid_attributes
      expect {
        delete :destroy, {:id => update.to_param, :board_id => board.to_param}, valid_session
      }.to change{board.reload.updates.count}.by(-1)
    end

    it "redirects to the updates list" do
      update = board.updates.create valid_attributes
      delete :destroy, {:id => update.to_param, :board_id => board.to_param}, valid_session
      expect(response).to redirect_to(board_updates_url(board))
    end
  end

end
