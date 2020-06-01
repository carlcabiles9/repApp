class Project < ApplicationRecord
  belongs_to :user, class_name: "User"
  has_many :project_users, class_name: "ProjectUser", dependent: :destroy
  has_many :participants, through: :project_users, source: :user

  searchable do
    text :name
    # integer :user_ids, :multiple=> true
    # sir ang boost po ng searchable para saan?
    # para mapabilis yung pag search para sa attribute. Optional lang yan bro. Ginagamit lang yan kapag important yung atttribute for searching.
    time :created_at
  end    
end
