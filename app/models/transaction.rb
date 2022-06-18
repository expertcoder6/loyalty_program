class Transaction < ApplicationRecord
	belongs_to :user
	belongs_to :product
	belongs_to :store
	belongs_to :loyalty_point,optional: true

	after_create :set_point
	after_create :set_bonus

	def set_point
		if self.store.country_type == "International"
			assign_international_point	
		else
			assign_national_point
		end
	end

	def assign_international_point
		point = self.amount.to_i > 100 ? ((self.amount.to_i / 10 ) * 2) : 20 
		loyalty_point = LoyaltyPoint.find_or_create_by(user_id: self.user_id)
		loyalty_point.update(point: loyalty_point.point + point)
		self.update(loyalty_point_id: loyalty_point_id)
		self.validation_context = "You have added with #{point} points"
	end

	def assign_national_point
		point = self.amount.to_i > 100 ? (self.amount.to_i / 10 ) : 10 
		loyalty_point = LoyaltyPoint.find_or_create_by(user_id: self.user_id)
		loyalty_point.update(point: loyalty_point.point + point)
		self.validation_context = "You have added with #{point} points"
		self.update(loyalty_point_id: loyalty_point.id)
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

