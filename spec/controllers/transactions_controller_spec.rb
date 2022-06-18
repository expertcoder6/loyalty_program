require 'rails_helper'

RSpec.describe TransactionsController,:type => :controller do
	before do
    @user = create(:user)

    sign_in @user
  end

	describe "GET index" do
		it "check index method" do		
			get :index,params: {user_id: @user.id}
			expect(response.status).to eq(200)
		end
  end

  describe "GET index" do
		it "check index method" do		
			get :create,params: {"transaction": {user_id: @user.id,product_id: 1,store_id: 1, loyalty_point_id: 1,amount: 300}}
			expect(response).to  redirect_to(store_products_path(1))
			expect(response.status).to eq(302)
		end
  end


end