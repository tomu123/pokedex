class Region < ApplicationRecord
  has_many :pokemon_regions
  has_many :pokemons, through: :pokemon_regions
end
