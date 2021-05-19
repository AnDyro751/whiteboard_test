FactoryBot.define do
  factory :user do
    email { "email-#{SecureRandom.hex}@gmail.com" }
    password { "123456" }
    confirmed_at { DateTime.now - 1.week.ago }
  end
end