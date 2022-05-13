class Pokemon < ApplicationRecord
  has_many :pokemon_regions
  has_many :regions, through: :pokemon_regions
  has_many :pokemon_types
  has_many :types, through: :pokemon_types
  has_many :pokemon_moves
  has_many :moves, through: :pokemon_moves
end
