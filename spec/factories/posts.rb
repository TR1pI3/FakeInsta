FactoryBot.define do
  factory :post do
    context { FFaker::Lorem.paragraph }
    association :user
  end
end
