# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.references :user
      t.text :firstname
      t.text :lastname
      t.text :number
      t.text :street
      t.text :bldg
      t.text :city
      t.text :province
      t.text :status

      t.timestamps
    end
  end
end
