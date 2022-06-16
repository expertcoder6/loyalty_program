class LoyaltyPoint < ApplicationRecord
	belongs_to :user
	has_many :transactions

	after_save :set_rewards
	after_save :set_plan
	after_create :set_bonus

	def set_rewards
		if self.point >= 100
			# if point is reaches to greater than 100 assign "Free Cofee Reward"
			reward = Reward.find_by(name: "Free Coffee Reward")
			UserReward.find_or_create_by(user_id: self.user_id,reward_id: reward.id)

			# assign 5% cash Rebate Reward
			transaction = Transaction.where(loyalty_point_id: self.id).where("amount > ?", 100.to_d)
			if transaction.count >= 10
				reward = Reward.find_by(name: "5% Cash Rebate Reward")
				UserReward.find_or_create_by(user_id: self.user_id,reward_id: reward.id)
			else
				start = Transaction.where(user_id: self.user).first.created_at
				endd = start + 60.days
				if Transaction.where(user_id: self.user,created_at: start..endd).where("amount > ? ", 1000.to_d)
					reward = Reward.find_by(name: "Free Movie Tickets")
					UserReward.find_or_create_by(user_id: self.user_id,reward_id: reward.id)
				else

				end
			end
		else
			if (Time.now.to_date.beginning_of_month..Time.now.to_date.end_of_month).include?(self.user.birthdate_date.to_date)
				reward = Reward.find_by(name: "Free Coffee Reward")
				UserReward.find_or_create_by(user_id: self.user_id,reward_id: reward.id)
			end 
		end
	end


	def set_plan
		if self.point >= 5000
			Plan.find_or_create_by(user_id:self.user_id,plan_type: "platinum tier")
			reward = Reward.find_by(name: "4x Airport Lounge Access Reward")
			UserReward.find_or_create_by(user_id: self.user_id,reward_id: reward.id)
		elsif self.point >= 1000
			Plan.find_or_create_by(user_id:self.user_id,plan_type: "gold tier")
		else
			Plan.find_or_create_by(user_id:self.user_id,plan_type: "standard tier")
		end
	end

	def set_bonus
		quarter = current_quarter_months(Time.now)
		case quarter
		when [1,2,3]
			start = Time.parse("01-01-#{Time.now.year} 00:00:00")
			endd = Time.parse("31-03-#{Time.now.year} 00:00:00")
			bonus(start,endd)
		when [4,5,6]
			start = Time.parse("01-04-#{Time.now.year} 00:00:00")
			endd = Time.parse("30-06-#{Time.now.year} 00:00:00")
			bonus(start,endd)
			

		when [7,8,9]
			start = Time.parse("01-07-#{Time.now.year} 00:00:00")
			endd = Time.parse("30-09-#{Time.now.year} 00:00:00")
			bonus(start,endd)
		else 
			start = Time.parse("01-10-#{Time.now.year} 00:00:00")
			endd = Time.parse("31-12-#{Time.now.year} 00:00:00")
			bonus(start,endd)
		end
	end

	def bonus(start,endd)
		if Transaction.where(user_id: self.user,created_at: start..endd).where("amount >= ?", 2000.to_d).count > 0
			self.user.loyalty_point.update(point: self.user.loyalty_point.point + 100 )
		end
	end

	def current_quarter_months(date)
	  quarters = [[1,2,3], [4,5,6], [7,8,9], [10,11,12]]
	  quarter = quarters[(date.month - 1) / 3]
	  return quarter
	end
end