FactoryBot.define do
  factory :user do
    username { FFaker::Internet.user_name }
    email { FFaker::Internet.safe_email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
