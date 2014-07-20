require 'rails_helper'

describe ClientsController do
  let(:valid_attributes) { {
    name: 'Acme Corp',
    shortname: 'acme',
    data: '{}'
  } }

  let(:invalid_attributes) { {
    name: ''
  } }

  let(:user) {
    User.create(email:'han@alliance.org', password: 'Solo is the name')
  }

  let(:client) { create(:client) }

  let(:valid_session) { {} }

  before(:all) do
    Client.destroy_all
    User.destroy_all
  end

  describe "GET index" do
    before(:each) do
      sign_in :user, user
    end

    it "displays nothing if user is not subscribed" do
      get :index, {}, valid_session
      expect(assigns(:clients)).to eq([])
    end

    it "displays all subscribed clients" do
      user.memberships << Membership.new(client: client)
      get :index, {}, valid_session
      expect(assigns(:clients)).to eq([client])
    end
  end

  describe "GET show" do
    it "is unreachable to a user who has no business looking into it" do
      sign_in :user, user
      get :show, { :id => client.to_param }, valid_session
      expect(response.status).to eq(403)
    end

    describe "by a client member" do
      before(:each) do
        user.memberships << Membership.new(client: client)
      end

      it "assigns the requested client as @client" do
        sign_in :user, user
        get :show, {:id => client.to_param}, valid_session
        expect(assigns(:client)).to eq(client)
      end
    end
  end

  describe "GET new" do
    it "assigns a new client as @client" do
      sign_in :user, user
      get :new, {}, valid_session
      expect(assigns(:client)).to be_a_new(Client)
    end
  end

  describe "GET edit" do
    it "assigns the requested client as @client" do
      client = Client.create! valid_attributes

      sign_in :user, user
      get :edit, {:id => client.to_param}, valid_session
      expect(assigns(:client)).to eq(client)
    end
  end

  describe "POST create" do
    before(:each) do
      sign_in :user, user
    end

    describe "with valid params" do
      it "creates a new Client" do
        expect {
          post :create, {:client => valid_attributes}, valid_session
        }.to change(Client, :count).by(1)
      end

      it "assigns a newly created client as @client" do
        post :create, {:client => valid_attributes}, valid_session
        expect(assigns(:client)).to be_persisted
      end

      it "redirects to the created client" do
        post :create, {:client => valid_attributes}, valid_session
        expect(response).to redirect_to(Client.last)
      end

      it "makes the creating user the administrator" do
        expect {
          post :create, {:client => valid_attributes}, valid_session
        }.to change(user.memberships.where(is_admin: true), :size).by(1)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved client as @client" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow(instance_double(Client)).to receive(:save).and_return(false)
        post :create, {:client => invalid_attributes}, valid_session
        expect(assigns(:client)).to be_a_new(Client)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow(instance_double(Client)).to receive(:save).and_return(false)
        post :create, {:client => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    before(:each) do
      sign_in :user, user
    end

    let(:client) { create(:client) }

    describe "by a curator" do
      before(:each) do
        # TODO: make user curator
      end

      it "updates the requested client"
    end

    describe "by a member" do
      describe "who has no adminstrator privileges" do
        before(:each) do
          create(:membership, is_admin: false, user: user, client: client)
        end

        it "is always ignored" do
          put :update, {:id => client.to_param, :client => valid_attributes}, valid_session
          p Ability.new(user).can? :update, client
          expect(response).to redirect_to(edit_client_url)
          #assert_response(403)
        end
      end

      describe "who is administrator" do
        before(:each) do
          create(:membership, is_admin: true, user: user, client: client)
        end
  
        describe "with invalid params" do
          it "assigns the client as @client" do
            allow(instance_double(Client)).to receive(:save).and_return(false)
            put :update, {:id => client.to_param, :client => invalid_attributes}, valid_session
            expect(assigns(:client)).to eq(client)
          end
    
          it "re-renders the 'edit' template" do
            allow(instance_double(Client)).to receive(:save).and_return(false)
            put :update, {:id => client.to_param, :client => invalid_attributes}, valid_session
            expect(response).to render_template("edit")
          end
        end
  
        describe "with valid params" do
          it "updates the requested client" do
            expect_any_instance_of(Client).to receive(:update).with({ "name" => "Something" })
            put :update, {:id => client.to_param, :client => { "name" => "Something" }}, valid_session
          end
    
          it "assigns the requested client as @client" do
            put :update, {:id => client.to_param, :client => valid_attributes}, valid_session
            expect(assigns(:client)).to eq(client)
          end
    
          it "redirects to the client" do
            put :update, {:id => client.to_param, :client => valid_attributes}, valid_session
            expect(response).to redirect_to(client)
          end
        end
      end
    end

    describe "by a nobody" do
      it "is discarded" do
        put :update, { :id => client.to_param, :client => valid_attributes}, valid_session
        assert_response 403
      end
    end

  end

  describe "DELETE destroy" do
    before(:each) do
      sign_in :user, user
    end

    let(:client) { create(:client) }

    describe "by a nobody" do
      it "is denied" do
        delete :destroy, {:id => client.to_param}, valid_session
        assert_response 403
      end
    end

    describe "by a client member" do
      before(:each) do
        Membership.create(user: user, client: client)
      end

      it "is denied" do
        delete :destroy, {:id => client.to_param}, valid_session
        assert_response 403
      end
    end

    describe "by the client curator" do
      before(:each) do
        # TODO: give memberships and curatorships a admin flag
        #
        # delete by a curator admin should remove the client from the 
        # curatorship but leave the client intact
        #
        # delete by a member admin should remove the client from listing, 
        # perhaps even remove the client entirely
        #client.curatorships << build(:curatorship, user: user)
      end

      it "destroys the requested client" do
        skip
        expect {
          delete :destroy, {:id => client.to_param}, valid_session
        }.to change(Client, :count).by(-1)
      end
  
      it "redirects to the clients list" do
        skip
        delete :destroy, {:id => client.to_param}, valid_session
        expect(response).to redirect_to(clients_url)
      end
    end
  end

end
