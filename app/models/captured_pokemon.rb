class CapturedPokemon < ApplicationRecord
  # Add support to free(softdelete) captured pokemons
  include SoftDelete
  belongs_to :pokemon
  belongs_to :user
end
