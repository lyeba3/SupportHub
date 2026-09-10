class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :name
      t.string :email
      t.string :role

      t.timestamps
    end
  end
end
