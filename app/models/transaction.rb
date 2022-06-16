class Transaction < ApplicationRecord
	belongs_to :user
	belongs_to :product
	belongs_to :store
	belongs_to :loyalty_point,optional: true

	after_create :set_point

	def set_point
		if self.store.country_type == "International"
			if self.amount.to_i > 100
				point = (self.amount.to_i / 10 ) * 2
				loyalty_point = LoyaltyPoint.find_or_create_by(user_id: self.user_id)
				loyalty_point.update(point: loyalty_point.point + point)
				self.validation_context = "You have added with #{point} points"
				self.update(loyalty_point_id: loyalty_point.id)
			else
				point = 20
				loyalty_point = LoyaltyPoint.find_or_create_by(user_id: self.user_id)
				loyalty_point.update(point: loyalty_point.point + point)
				self.validation_context = "Your have added with #{point} points  "
				self.update(loyalty_point_id: loyalty_point.id)
			end
		else
			if self.amount.to_i > 100
				point = (self.amount.to_i / 10 ) 
				loyalty_point = LoyaltyPoint.find_or_create_by(user_id: self.user_id)
				loyalty_point.update(point: loyalty_point.point + point)
				self.validation_context = "You have added with #{point} points"
				self.update(loyalty_point_id: loyalty_point.id)
			else
				point = 10
				loyalty_point = LoyaltyPoint.find_or_create_by(user_id: self.user_id)
				loyalty_point.update(point: loyalty_point.point + point)
				self.validation_context = "Your have added with #{point} points "
				self.update(loyalty_point_id: loyalty_point.id)
			end
		end
	end
end

