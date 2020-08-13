# frozen_string_literal: true

class Recipient < ApplicationRecord
  has_many :project_recipients, dependent: :destroy
  has_many :projects, through: :project_recipients, dependent: :destroy
  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }
  validates :email, uniqueness: true
end
