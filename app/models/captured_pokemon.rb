class CapturedPokemon < ApplicationRecord
  belongs_to :pokemon
  belongs_to :user
end
