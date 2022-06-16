class Store < ApplicationRecord
	enum country_type: {International: "International",National: "National"}

	belongs_to :admin,class_name: "User",foreign_key: :admin_id
	has_many :products
end
