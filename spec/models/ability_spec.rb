require 'rails_helper'

describe Ability, :type => :model do
  let(:user) { create(:user) }
  let(:client) { create(:client) }
  let(:curator) { create(:curator) }

  it "denied non-curators to modify clients" do
    expect(Ability.new(user).can? :manage, curator).to be(false)
    expect(Ability.new(user).can? :manage, create(:client, curator: curator)).to be(false)
  end

  describe "for curators" do
    let(:curatorship) { create(:curatorship, user: user, curator: curator) }

    describe "to curate client" do
      it "does not exists for non-assigned client" do
        expect(Ability.new(user).can? :curate, client).to be(false)
      end

      it "exists for assigned client" do
        expect(curatorship).to be_persisted
        expect(Ability.new(user).can? :curate, create(:client, curator: curator)).to be(true)
      end
    end

    describe "to manage clients" do
      it "does not exists for non-administrative curators" do
        expect(Ability.new(user).can? :manage, create(:client, curator: curator)).to be(false)
      end

      it "does not exists for administrative curators" do
        curatorship.is_admin = true
        curatorship.save
        expect(Ability.new(user).can? :manage, client).to be(true)
      end
    end

    describe "to manage curators" do
      it "does not exist for non-administrative curators" do
        expect(Ability.new(user).can? :manage, curator).to be(false)
      end

      it "exists for administrators" do
        curatorship.is_admin = true
        curatorship.save
        expect(Ability.new(user).can? :manage, curator).to be(true)
      end
    end

    describe "to deactivate a curator" do
      it "does not exists for non-administrative curators" do
        expect(Ability.new(user).can? :deactivate, curator).to be(false)
      end

      it "is reserved to administrators" do
        curatorship.is_admin = true
        curatorship.save
        expect(Ability.new(user).can? :deactivate, curator).to be(true)
      end
    end

    describe "to remove a curator" do
      it "is not available to regular users" do
        expect(Ability.new(user).can? :destroy, curator).to be(false)
      end

      it "is not even available to administrators" do
        curatorship.is_admin = true
        curatorship.save
        expect(Ability.new(user).can? :destroy, curator).to be(false)
      end

      describe "that has been disabled" do
        before do
          curator.is_active = false
          curator.save
        end

        it "is not available for regular users" do
          expect(Ability.new(user).can? :destroy, curator).to be(false)
        end

        it "is only reserved to administrators" do
          curatorship.is_admin = true
          curatorship.save
          expect(Ability.new(user).can? :destroy, client).to be(true)
        end
      end
    end
  end

  describe "for members" do
    let(:membership) { create(:membership, user: user, client: client) }

    describe "to view client information" do
      it "exists" do
        expect(membership).to be_persisted
        expect(Ability.new(user).can? :read, client).to be(true)
      end
    end

    describe "to manage a client" do
      it "does not exist for non-administrative users" do
        expect(Ability.new(user).can? :manage, client).to be(false)
      end

      it "exists for administrators" do
        membership.is_admin = true
        membership.save
        expect(Ability.new(user).can? :manage, client).to be(true)
      end
    end

    describe "to update a client" do
      it "is not available to regular users" do
        expect(Ability.new(user).can? :update, client).to be(false)
      end

      it "is reserved to administrators" do
        membership.is_admin = true
        membership.save
        expect(Ability.new(user).can? :update, client).to be(true)
      end
    end

    describe "to deactivate a client" do
      it "is not available to regular users" do
        expect(Ability.new(user).can? :deactivate, client).to be(false)
      end

      it "is reserved to administrators only" do
        membership.is_admin = true
        membership.save
        expect(Ability.new(user).can? :deactivate, client).to be(true)
      end
    end

    describe "to remove a client" do
      it "is not available to regular users" do
        expect(Ability.new(user).can? :destroy, client).to be(false)
      end

      it "is not even available to administrators" do
        membership.is_admin = true
        membership.save
        expect(Ability.new(user).can? :destroy, client).to be(false)
      end

      describe "that has been disabled" do
        before do
          client.is_active = false
          client.save
        end

        it "is not available to regular users" do
          expect(Ability.new(user).can? :destroy, client).to be(false)
        end

        it "is only reserved to administrators" do
          membership.is_admin = true
          membership.save
          expect(Ability.new(user).can? :destroy, client).to be(true)
        end
      end
    end
  end

  describe "for anyone" do
    describe "to create a client" do
      it "exists" do
        client = build(:client)
        expect(Ability.new(user).can? :create, client).to be(true)
      end
    end
  
    describe "to modify client information" do
      it "does not exist" do
        expect(Ability.new(user).can? :update, client).to be(false)
      end
    end
  
    
    describe "to update client information" do
      it "does not exist" do
        expect(Ability.new(user).can? :update, client).to be(false)
      end
    end

    describe "to read client information" do
      it "does not exist" do
        expect(Ability.new(user).can? :read, client).to be(false)
      end
    end

    describe "to manage clients" do
      it "does not exist" do
        expect(Ability.new(user).can? :manage, curator).to be(false)
        expect(Ability.new(user).can? :manage, create(:client, curator: curator)).to be(false)
      end
    end
  end
end
