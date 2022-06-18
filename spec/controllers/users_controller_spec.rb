require 'rails_helper'

RSpec.describe UsersController,:type => :controller do

	describe "GET index" do
		let(:user) {create(:user)}
		let(:admin) {create(:user,email: "admin1@yopmail.com",is_admin: true)}

		it "normal user" do		
			sign_in user
			get :index
			expect(response.status).to eq(200)
		end

		it "admin user" do
			sign_in admin
			get :index
			expect(response.status).to eq(200)
		end
  end

  describe "GET rewards" do
  	let(:user) {create(:user)}
		it "check rewards" do		
			sign_in user
			get :rewards,params: {user_id: user.id}
			expect(response.status).to eq(200)
		end
  end

  describe "GET points" do
  	let(:user) {create(:user)}
		it "check points" do		
			sign_in user
			get :points,params: {user_id: user.id}
			expect(response.status).to eq(200)
		end
  end
end