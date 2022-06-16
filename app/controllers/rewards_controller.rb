class RewardsController < ApplicationController
	before_action :check_admin
	def new
		@reward = Reward.new
	end

	def create
		@reward = Reward.new(reward_params)
		if @reward.save
			redirect_to admin_path
		else
			render 'new'
		end
	end

	private 
	def check_admin
		if current_user.is_admin == true
			@admin = current_user
		end
	end

	def reward_params
		params.require(:reward).permit(:name,:value,:admin_id,:user_id)
	end
end
