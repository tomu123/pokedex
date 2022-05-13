class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :given_name, null: false
      t.string :family_name, null: false

      t.timestamps
    end
  end
end
