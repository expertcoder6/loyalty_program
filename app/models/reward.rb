class Reward < ApplicationRecord
	validates :name,uniqueness: true
	belongs_to :admin,class_name: "User",foreign_key: :admin_id
	belongs_to :user,class_name: "User",foreign_key: :user_id,optional: true
end
