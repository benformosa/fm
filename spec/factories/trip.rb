require 'faker'

FactoryGirl.define do
  factory :trip do |f|
    f.date { Faker::Date.backward(14) }
    f.odo { Faker::Number.number(2) }
    f.location { Faker::Address.city }
  end
end
