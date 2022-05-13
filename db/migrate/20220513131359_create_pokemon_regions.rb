class CreatePokemonRegions < ActiveRecord::Migration[6.1]
  def change
    create_table :pokemon_regions do |t|
      t.references :pokemon, null: false, foreign_key: true
      t.references :region, null: false, foreign_key: true

      t.timestamps
    end
  end
end
