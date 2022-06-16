class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :rewards,class_name: "Reward",foreign_key: :admin_id
  has_many :stores,class_name: "Store",foreign_key: :admin_id
  has_many :transactions
  has_one :loyalty_point
  has_many :user_rewards
  has_one :plan
end
