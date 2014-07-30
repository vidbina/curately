require 'rails_helper'

describe TemplatesController, :type => :controller do
  before(:each) { Template.destroy_all }
  #let(:template) { create(:template) }
  let(:valid_session) { {} }
  let(:valid_attributes) { build(:template).attributes }
  let(:invalid_attributes) { build(:template, name: nil).attributes }
  let(:user) { create(:user) }
  let(:curatorship) { create(:curatorship, user: user) }

  describe "GET index" do
    it "is not accessible if not logged in" do
      skip
      get :index, { curator_id: curatorship.curator.id }, valid_session
      assert_response 401
    end

    it "is not accessible to non-curators" do
      skip
      user = create(:user)

      sign_in :user, user
      get :index, { curator_id: curatorship.curator.id }, valid_session
      assert_response 403
    end

    it "redirects to new if it does not exists" do
      skip
      curatorship.curator.template.destroy
      get :index, { curator_id: curatorship.curator.id }, valid_session
      assert_response 404
      #expect(response).to redirect_to(curator_new_template_url(curator_id: curatorship.curator.id))
    end

    it "assigns the template as @template" do
      skip
      sign_in :user, curatorship.user
      get :index, { curator_id: curatorship.curator.id }, valid_session
      expect(assigns(:template)).to eq(curatorship.curator.template)
    end
  end

  describe "GET new" do
    it "is not accessible" do
      skip
      sign_in
      get :new, { curator_id: curatorship.curator.id }, valid_session
      assert_response 401
    end

    describe "by non-admin curator" do
      before(:example) do
        curatorship.is_admin = false
        curatorship.save

        sign_in :user, user
      end
  
      it "is forbidden" do
        get :new, { curator_id: curatorship.curator.id }, valid_session
        assert_response 403
      end
    end

    describe "by curator admin" do
      before do
        curatorship.is_admin = true
        curatorship.save
        sign_in :user, user
      end

      it "assigns a new template as @template" do
        curatorship.curator.template.destroy
        get :new, { curator_id: curatorship.curator.id }, valid_session
        expect(assigns(:template)).to be_a_new(Template)
      end

      it "redirects to the template if it already exists" do
        get :new, { curator_id: curatorship.curator.id }, valid_session
        expect(response).to redirect_to(curator_template_url)
      end
    end
  end

  describe "GET edit" do
    it "is not accessible if not logged in" do
      skip
      get :edit, { curator_id: curatorship.curator.id }, valid_session
      assert_response 401
    end

    it "is not accessible to non-curators" do
      sign_in :user, create(:user)
      get :edit, { curator_id: curatorship.curator.id }, valid_session
      assert_response 403
    end

    describe "by non-admin" do
      before(:example) do
        curatorship.is_admin = false
        curatorship.save
        sign_in :user, user
      end
    end

    describe "by curator admin" do
      before(:example) do
        curatorship.is_admin = false
        curatorship.save
        sign_in :user, user
      end
  
      it "redirects to new if it does not exists" do
        curatorship.curator.template.destroy
        get :edit, { curator_id: curatorship.curator.id }, valid_session
        assert_response 404
        #expect(response).to redirect_to(curator_new_template_url(curator_id: curatorship.curator.id))
      end

      it "assigns the curator template as @template" do
        get :edit, { curator_id: curatorship.curator.id }, valid_session
        expect(assigns(:template)).to eq(curatorship.curator.template)
      end
    end
  end

  describe "POST create" do
    describe "by a signed in user" do
      before(:each) do
        sign_in :user, user
      end

      it "is rejected for non-curators" do
        curatorship.destroy
        post :create, { 
          curator_id: curatorship.curator.id,
          template: valid_attributes 
        }, valid_session
        assert_response 403
      end

      it "is rejected for non-administrative curators without templates" do
        curatorship.curator.template.destroy
        curatorship.is_admin = false
        curatorship.save

        post :create, { 
          curator_id: curatorship.curator.id,
          template: valid_attributes 
        }, valid_session
        assert_response 403
      end

      it "is accepted for curator admins without templates" do
        curatorship.curator.template.destroy
        curatorship.is_admin = true
        curatorship.save

        post :create, { 
          curator_id: curatorship.curator.id,
          template: valid_attributes 
        }, valid_session
        expect(response).to redirect_to(curator_template_url)
      end
    end
  end

  describe "PUT update" do
    describe "by a signed in user" do
      before(:example) do
        sign_in :user, user
      end

      describe "with valid params" do
        describe "without administrative curator privileges" do
          before(:each) do
            curatorship.is_admin = false
            curatorship.save
          end

          it "forbids a update" do
            put :update, { 
              curator_id: curatorship.curator.id, 
              template: { name: 'Sitcom' } 
            }, valid_session
            assert_response 403
          end
        end

        describe "having administrative curator privileges" do
          before(:each) do
            curatorship.is_admin = true
            curatorship.save
          end

          it "updates the template" do
            expect_any_instance_of(Template).to receive(:update)
            put :update, { 
              curator_id: curatorship.curator.id, 
              template: { name: 'Sitcom' } 
            }, valid_session
          end
  
          it "assigns the requested template as @template" do
            put :update, { 
              curator_id: curatorship.curator.id, 
              template: { name: 'Cartoon' } 
            }, valid_session
            expect(assigns(:template)).to eq(curatorship.curator.template)
          end
  
          it "redirects to the template" do
            put :update, { 
              curator_id: curatorship.curator.id, 
              template: { name: 'Comedy' } 
            }, valid_session
            expect(response).to redirect_to(curator_template_url)
          end
  
          it "is rejected if the template does not exist" do
            curatorship.curator.template.destroy
            put :update, { 
              curator_id: curatorship.curator.id, 
              template: { name: 'Comedy' } 
            }, valid_session
            assert_response 404
          end
        end
      end
    end
  end
end
