require 'faker'

FactoryBot.define do
    factory :user do
        username {Faker::Lorem.word}
        email{}
        password{}
    end
end