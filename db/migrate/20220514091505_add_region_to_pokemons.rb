class AddRegionToPokemons < ActiveRecord::Migration[6.1]
  def change
    add_reference :pokemons, :region, null: false, foreign_key: true
  end
end
