# frozen_string_literal: true

class CreateRecipients < ActiveRecord::Migration[6.0]
  def change
    create_table :recipients do |t|
      t.string :email
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
