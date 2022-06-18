require "rails_helper"

RSpec.describe Transaction, :type => :model do
	describe "association" do
		context "user has one plan" do
      let(:user) { create(:user) }
      let!(:store) { create(:store,admin_id: user.id) }
      let!(:product) {create(:product,store_id: store.id)}
      let!(:transaction) {create(:transaction,user_id: user.id,store_id: store.id,product_id: product.id)}
      let(:transaction1) {create(:transaction,user_id: user.id,store_id: store.id,product_id: product.id)}
      let(:loyalty_point) {create(:loyalty_point,user_id: user.id)}

      it "loyalty_point belongs to user" do
        expect(loyalty_point.user).to eq(user)
      end

      it "loyalty_point has many transactions" do
      	transaction.update(loyalty_point_id: loyalty_point.id)
      	transaction1.update(loyalty_point_id: loyalty_point.id)
        expect(loyalty_point.reload.transactions).to eq([transaction,transaction1])
      end
    end
	end

	describe "callbacks" do
		context "free coffee reward" do
			let(:user) { create(:user) }
			let(:admin) { create(:user,is_admin: true,email: "admin1@yopmail.com") }
      let!(:store) { create(:store,admin_id: admin.id) }
      let!(:product) {create(:product,store_id: store.id)}
      let!(:transaction) {create(:transaction,user_id: user.id,store_id: store.id,product_id: product.id)}
     
			it "free coffee reward for birthday month" do
				reward =  Reward.find_by(name: "Free Coffee Reward")
				user_reward = user.user_rewards.where(reward_id: reward,reason: "birthday_month").first
				expect(user_reward.reward_id).to eq(reward.id)
			end
			it "free coffee reward for " do
				reward =  Reward.find_by(name: "Free Coffee Reward")
				user_reward = user.user_rewards.where(reward_id: reward,reason: "birthday_month").first
				expect(user_reward.reward_id).to eq(reward.id)
			end
		end

		context " 5% cash rebate reward" do
			let(:user) { create(:user) }
			let(:admin) { create(:user,is_admin: true,email: "admin1@yopmail.com") }
      let!(:store) { create(:store,admin_id: admin.id) }
      let!(:product) {create(:product,store_id: store.id)}
      let!(:transaction1) {create(:transaction,user_id: user.id,store_id: store.id,product_id: product.id,amount: 1000)}
      let!(:transaction2) {create(:transaction,user_id: user.id,store_id: store.id,product_id: product.id,amount: 1000)}
      let!(:transaction3) {create(:transaction,user_id: user.id,store_id: store.id,product_id: product.id,amount: 1000)}
      let!(:transaction4) {create(:transaction,user_id: user.id,store_id: store.id,product_id: product.id,amount: 1000)}
      let!(:transaction5) {create(:transaction,user_id: user.id,store_id: store.id,product_id: product.id,amount: 1000)}
      let!(:transaction6) {create(:transaction,user_id: user.id,store_id: store.id,product_id: product.id,amount: 1000)}
      let!(:transaction7) {create(:transaction,user_id: user.id,store_id: store.id,product_id: product.id,amount: 1000)}
      let!(:transaction8) {create(:transaction,user_id: user.id,store_id: store.id,product_id: product.id,amount: 1000)}
      let!(:transaction9) {create(:transaction,user_id: user.id,store_id: store.id,product_id: product.id,amount: 1000)}
      let!(:transaction10) {create(:transaction,user_id: user.id,store_id: store.id,product_id: product.id,amount: 1000)}
     
			it " 5% cash rebate reward" do
				reward =  Reward.find_by(name: "5% Cash Rebate Reward")
				user_reward = user.user_rewards.where(reward_id: reward,reason: "10 or more transactions whoes amount > $100").first
				expect(user_reward.reward_id).to eq(reward.id)
			end
		end

		context "free movie ticket reward if spent > $1000 within 60 days of first transaction" do
			let(:user) { create(:user) }
			let(:admin) { create(:user,is_admin: true,email: "admin1@yopmail.com") }
      let!(:store) { create(:store,admin_id: admin.id) }
      let!(:product) {create(:product,store_id: store.id)}
      let!(:transaction) {create(:transaction,user_id: user.id,store_id: store.id,product_id: product.id,amount: 2000)}
     
			it "free movie ticket reward if spent > $1000 within 60 days of first transaction" do
				reward =  Reward.find_by(name: "Free Coffee Reward")
				user_reward = user.user_rewards.where(reward_id: reward,reason: "birthday_month").first
				expect(user_reward.reward_id).to eq(reward.id)
			end
			it "free coffee reward for " do
				reward =  Reward.find_by(name: "Free Movie Tickets")
				user_reward = user.user_rewards.where(reward_id: reward,reason: "spent more than 1000 within 60 days of first transaction").first
				expect(user_reward.reward_id).to eq(reward.id)
			end
		end

		context "check standard tier" do
			let(:user) { create(:user) }
			let(:admin) { create(:user,is_admin: true,email: "admin1@yopmail.com") }
      let!(:store) { create(:store,admin_id: admin.id) }
      let!(:product) {create(:product,store_id: store.id)}
      let!(:transaction) {create(:transaction,user_id: user.id,store_id: store.id,product_id: product.id,amount: 100)}
			
			it "standard tier" do
				expect(user.plan.plan_type).to eq("standard tier")
			end
		end

		context "check gold tier" do
			let(:user) { create(:user) }
			let(:admin) { create(:user,is_admin: true,email: "admin1@yopmail.com") }
      let!(:store) { create(:store,admin_id: admin.id) }
      let!(:product) {create(:product,store_id: store.id)}
      let!(:transaction1) {create(:transaction,user_id: user.id,store_id: store.id,product_id: product.id,amount: 5000,created_at: Time.now - 1.month)}
			
			it "gold tier" do
				expect(user.plan.plan_type).to eq("gold tier")
			end
		end

		context "check platinum tier" do
			let(:user) { create(:user) }
			let(:admin) { create(:user,is_admin: true,email: "admin1@yopmail.com") }
      let!(:store) { create(:store,admin_id: admin.id) }
      let!(:product) {create(:product,store_id: store.id)}
      let!(:transaction1) {create(:transaction,user_id: user.id,store_id: store.id,product_id: product.id,amount: 50000,created_at: Time.now - 1.month)}
			
			it "platinum tier" do
				expect(user.plan.plan_type).to eq("platinum tier")
			end
		end
	end
end





	# "4x Airport Lounge Access Reward","user plan is gold tier")