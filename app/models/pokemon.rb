class Pokemon < ApplicationRecord
  belongs_to :region
  has_and_belongs_to_many :types
  has_many :pokemon_moves
  has_many :moves, through: :pokemon_moves
end
