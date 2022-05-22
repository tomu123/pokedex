FactoryBot.define do
  factory :captured_pokemon do
    name { pokemon.name }
    hp { pokemon.hp }
    attack { pokemon.attack }
    defense { pokemon.defense }
    special_attack { pokemon.special_attack }
    special_defense { pokemon.special_defense }
    speed { pokemon.speed }
    pokemon
    user
  end
end
