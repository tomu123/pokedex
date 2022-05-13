class PokemonRegion < ApplicationRecord
  belongs_to :pokemon
  belongs_to :region
end
