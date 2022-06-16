class UsersController < ApplicationController

	def index
		if current_user.is_admin == true
			@rewards = Reward.all
		else
			@stores = Store.all
		end 
	end

	def admin
		@rewards = Reward.all
	end

	def rewards
		@user = User.find(params[:user_id])
		@rewards = Reward.all
		@user_rewards = @user.user_rewards.order("reward_id asc")
	end

	def points
		@user = User.find(params[:user_id])
		@point = @user.loyalty_point
	end
end
