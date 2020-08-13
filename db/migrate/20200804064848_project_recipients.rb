class ProjectRecipients < ActiveRecord::Migration[6.0]
  def change
    create_table :project_recipients do |t|
      t.references :recipient, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
