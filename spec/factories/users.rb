FactoryBot.define do
  factory :user do
    username { FFaker::Lorem.characters(5) }
    email { FFaker::Internet.safe_email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
