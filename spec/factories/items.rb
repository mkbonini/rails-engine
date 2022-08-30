FactoryBot.define do
  factory :item do
    association :merchant
    name { Faker::Appliance.equipment }
    description { Faker::Lorem.sentence }
    unit_price { Faker::Number.decimal(l_digits: 2) }
  end
end