require "rails_helper"

RSpec.describe User, :type => :model do
  describe "associations" do
    context "user has one plan" do
      let(:user) { create(:user) }

      it "user has one plan" do
        user = create(:user)
        plan = Plan.find_or_create_by(user_id: user.id)
        expect(user.plan).to eq(plan)
      end

      it "belongs to user" do
         user = create(:user)
         plan = Plan.find_or_create_by(user_id: user.id)
         expect(plan.user).to eq(user)
      end
    end

    context "user has many  stores" do
      let(:user) { create(:user,is_admin: true) }
      let(:store) { create(:store,admin_id: user.id) }
      let(:store1) { create(:store,admin_id: user.id) }

      it "user has many stores" do
        plan = Plan.find_or_create_by(user_id: user.id)
        expect(user.reload.stores).to eq([store,store1])
      end

      it "store belongs to user" do
         expect(store.admin).to eq(user)
      end
    end

    context "user has many  transactions" do
      let(:user) { create(:user,is_admin: true) }
      let(:store) { create(:store,admin_id: user.id) }
      let(:product) {create(:product,store_id: store.id)}
      let(:transaction) {create(:transaction,user_id: user.id,store_id: store.id,product_id: product.id)}
      let(:transaction1) {create(:transaction,user_id: user.id,store_id: store.id,product_id: product.id)}

      it "user has many stores" do
        expect(user.reload.transactions).to eq([transaction,transaction1])
      end

      it "store belongs to user" do
         expect(store.admin).to eq(user)
      end
    end

    context "user has one loyalty_point" do
      let(:user) { create(:user,is_admin: true) }
      let(:store) { create(:store,admin_id: user.id) }
      let(:product) {create(:product,store_id: store.id)}
      let(:transaction) {create(:transaction,user_id: user.id,store_id: store.id,product_id: product.id)}
    
      it "user has many stores" do
        expect(transaction).to respond_to(:set_point)
        loyalty_point = LoyaltyPoint.find_or_create_by(user_id: user.id)
        expect(user.reload.loyalty_point).to eq(loyalty_point)
      end
    end

    context "user has many rewards" do
      let(:user) { create(:user,is_admin: true) }
      let(:store) { create(:store,admin_id: user.id) }
      let(:product) {create(:product,store_id: store.id)}
      let!(:transaction) {create(:transaction,user_id: user.id,store_id: store.id,product_id: product.id,amount: 100)}


      it "user has many stores" do
        user_reward = UserReward.find_by(user_id: user.id)
        expect(user.user_rewards).to eq([user_reward])
      end
    end
  end

  describe "callbacks" do
    let(:user) {create(:user)}

    it "check callback" do
      expect(user).to respond_to(:set_tier_plan)
    end
  end
end



