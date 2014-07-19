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

  let(:valid_session) { {} }

  before(:all) do
    Client.destroy_all
    User.destroy_all
  end

  describe "GET index" do
    before(:each) do
      @client = Client.create! valid_attributes
      sign_in :user, user
    end

    it "displays nothing if user is not subscribed" do
      get :index, {}, valid_session
      expect(assigns(:clients)).to eq([])
    end

    it "displays all subscribed clients" do
      user.memberships << Membership.new(client: @client)
      get :index, {}, valid_session
      expect(assigns(:clients)).to eq([@client])
    end
  end

  describe "GET show" do
    it "assigns the requested client as @client" do
      client = Client.create! valid_attributes

      sign_in :user, user
      get :show, {:id => client.to_param}, valid_session
      expect(assigns(:client)).to eq(client)
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

    describe "with valid params" do
      it "updates the requested client" do
        client = Client.create! valid_attributes
        expect_any_instance_of(Client).to receive(:update).with({ "name" => "Something" })
        put :update, {:id => client.to_param, :client => { "name" => "Something" }}, valid_session
      end

      it "assigns the requested client as @client" do
        client = Client.create! valid_attributes
        put :update, {:id => client.to_param, :client => valid_attributes}, valid_session
        expect(assigns(:client)).to eq(client)
      end

      it "redirects to the client" do
        client = Client.create! valid_attributes
        put :update, {:id => client.to_param, :client => valid_attributes}, valid_session
        expect(response).to redirect_to(client)
      end
    end

    describe "with invalid params" do
      it "assigns the client as @client" do
        client = Client.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow(instance_double(Client)).to receive(:save).and_return(false)
        put :update, {:id => client.to_param, :client => invalid_attributes}, valid_session
        expect(assigns(:client)).to eq(client)
      end

      it "re-renders the 'edit' template" do
        client = Client.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow(instance_double(Client)).to receive(:save).and_return(false)
        put :update, {:id => client.to_param, :client => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      sign_in :user, user
    end

    it "destroys the requested client" do
      client = Client.create! valid_attributes
      expect {
        delete :destroy, {:id => client.to_param}, valid_session
      }.to change(Client, :count).by(-1)
    end

    it "redirects to the clients list" do
      client = Client.create! valid_attributes
      delete :destroy, {:id => client.to_param}, valid_session
      expect(response).to redirect_to(clients_url)
    end
  end

end
