FactoryBot.define do
  factory :transaction do
    product_id { 1 }
    store_id  { 1 }
    user_id { 1 }
    amount { 200 }
    loyalty_point_id {1}
  end
end