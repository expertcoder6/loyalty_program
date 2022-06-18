require "rails_helper"

RSpec.describe Transaction, :type => :model do
	describe "associations" do
    context "user has one plan" do
      let(:user) { create(:user) }
      let(:store) { create(:store,admin_id: user.id) }
      let(:product) {create(:product,store_id: store.id)}
      let(:transaction) {create(:transaction,user_id: user.id,store_id: store.id,product_id: product.id)}

      it "transaction belongs to user" do 
        expect(transaction.user).to eq(user)
      end

      it "transaction belongs  to product" do
         expect(transaction.product).to eq(product)
      end

      it "transaction belongs  to store" do
         expect(transaction.store).to eq(store)
      end
    end
  end

  describe "check callbacks" do
  	let(:user) {create(:user)}
  	 let(:store) { create(:store,admin_id: user.id) }
      let(:product) {create(:product,store_id: store.id)}
      let(:transaction) {create(:transaction,user_id: user.id,store_id: store.id,product_id: product.id)}

    it "check callback set_point" do
      expect(transaction).to respond_to(:set_point)
    end
    it "check callback set_bonus" do
      expect(transaction).to respond_to(:set_bonus)
    end
  end
end
