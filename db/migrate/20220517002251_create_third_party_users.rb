class CreateThirdPartyUsers < ActiveRecord::Migration[6.1]
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL
          CREATE TYPE authentication_provider AS ENUM ('google', 'facebook');
        SQL
      end

      dir.down do
        execute <<-SQL
          DROP TYPE authentication_provider;
        SQL
      end
    end
    create_table :third_party_users do |t|
      t.string :provider_id, null: false
      t.references :user, null: false, foreign_key: true
      t.column :provider, :authentication_provider, null: false

      t.timestamps
      t.index [:provider,:provider_id]
      t.index [:provider_id,:provider]
    end
  end
end
