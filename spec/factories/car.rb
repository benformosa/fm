require 'faker'

FactoryGirl.define do
  factory :car do |f|
    f.name { Faker::Lorem.word }
    f.make { Faker::Company.name }
    f.model { Faker::Lorem.word }
    f.rego { Faker::Lorem.characters(3) + ' ' + Faker::Number.number(3) }
    f.state { Faker::Team.state }
    f.initial_location { Faker::Address.city }
    f.start_odo { Faker::Number.number(1) }
  end
end
