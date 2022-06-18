FactoryBot.define do
  factory :user_reward do
    reward_id { 1 }
    user_id  { 1 }
    product_id { 1 }
    store_id { 1 }
    reason {"birthday_month"}
  end
end