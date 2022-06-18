FactoryBot.define do
  factory :user do
    email { "test@gmail.com" }
    password  { "123456" }
    password_confirmation { "123456" }
    username { "test" }
    birthday { Time.now}
    is_admin { false}
  end
end