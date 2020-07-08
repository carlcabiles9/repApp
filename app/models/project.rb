# frozen_string_literal: true

class Project < ApplicationRecord
  validates :name, presence: true
  belongs_to :user, class_name: 'User'
  has_many :reports, dependent: :destroy
  has_many :project_users, class_name: 'ProjectUser', dependent: :destroy
  has_many :participants, through: :project_users, source: :user
  searchable do
    text :name, boost: 5
    time :created_at
  end
end
