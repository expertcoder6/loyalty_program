class LoyaltyPoint < ApplicationRecord
	belongs_to :user
	has_many :transactions

	after_save :set_plan
	after_save :free_coffee_reward
	after_save :cash_rebate_reward
	after_save :free_movie_tickets_reward


	def free_coffee_reward
		# coffee reward if user birthday month 
		if (Time.now.to_date.beginning_of_month..Time.now.to_date.end_of_month).include?(self.user.birthday.to_date)
			assign_reward("Free Coffee Reward","birthday_month")
		end

		# cofee reward when user accumulates 100 points
		
		total_point = transaction_details(Time.now.to_date.beginning_of_month,Time.now.to_date.end_of_month)
		if total_point >= 100
			assign_reward("Free Coffee Reward","user accumulates 100 points in one calendar month")
		end
	end

	def transaction_details(start,endd)
		total_point = 0
		Transaction.where(user_id: self.user,created_at: start..endd).each do |t|
			point = calculate_calander_points(t)
			total_point += point
		end
		return total_point
	end

	def calculate_calander_points(data)
		if data.store.country_type == "National"
			point = data.amount.to_i > 100 ? (data.amount.to_i / 10 ) : 10 
			return point
		else
			point = data.amount.to_i > 100 ? ((data.amount.to_i / 10 ) * 2) : 20 
			return point
		end
	end

	# 5% cash rebate reward if 10 more transaction of amout greater than $100
	def cash_rebate_reward
		transaction = Transaction.where(user_id: self.user).where("amount > ?", 100.to_d)
		if transaction.count >= 10
			assign_reward("5% Cash Rebate Reward","10 or more transactions whoes amount > $100")
		end
	end

	# free movie ticket reward if spent > $1000 within 60 days of first transaction
	def free_movie_tickets_reward
		start = Transaction.where(user_id: self.user).first.created_at 
		endd = start + 60.days
		if Transaction.where(user_id: self.user,created_at: start..endd).where("amount > ? ", 1000.to_d).present?
			assign_reward("Free Movie Tickets","spent more than 1000 within 60 days of first transaction")
		end
	end

	def assign_reward(name,reason)
		reward = Reward.find_by(name: name)
		UserReward.find_or_create_by(reason: reason,user_id: self.user_id,reward_id: reward.id)
	end 

	def set_plan
		total_point = transaction_details(Time.now.to_date.beginning_of_month - 2.month,Time.now.to_date.end_of_month - 1.month)
		if total_point >= 5000
			Plan.find_by(user_id: self.user).update(plan_type: "platinum tier")
		elsif total_point >= 1000
			Plan.find_by(user_id: self.user).update(plan_type: "gold tier")
			assign_reward("4x Airport Lounge Access Reward","user plan is gold tier")
		else
			Plan.find_by(user_id: self.user).update(plan_type: "standard tier")
		end
	end
end