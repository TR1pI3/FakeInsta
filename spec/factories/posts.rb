FactoryBot.define do
  factory :post do
    body { FFaker::Lorem.paragraph }
    image { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/image.png'))) }
    association :user

    trait :liked do
      after(:create) do |post, evaluator|
        create(:like, post:, user: evaluator.user)
      end
    end
  end
end
