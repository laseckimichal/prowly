class CreateAdresses < ActiveRecord::Migration[6.1]
  def change
    create_table :adresses do |t|
      t.string :city, null: false
      t.string :street
      t.integer :street_number
      t.references :contact, foreign_key: true, null: false

      t.timestamps
    end
  end
end
