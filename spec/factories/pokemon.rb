FactoryBot.define do
  factory :pokemon do
    name { Faker::Games::Pokemon.name }
    height { rand(10..20) }
    weight { rand(10..20) }
    hp { rand(10..20) }
    attack { rand(10..20) }
    defense { rand(10..20) }
    special_attack { rand(10..20) }
    special_defense { rand(10..20) }
    speed { rand(10..20) }
    description { Faker::Lorem.sentence }
    region
    types { [association(:type)] }
  end
end
