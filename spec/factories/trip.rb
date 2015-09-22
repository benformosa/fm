require 'faker'

FactoryGirl.define do
  factory :trip do |f|
    f.date { Date.today }
    f.odo { Faker::Number.number(2) }
    f.location { Faker::Address.city }
  end
end
