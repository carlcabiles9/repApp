# frozen_string_literal: true

class ProjectUser < ApplicationRecord
  belongs_to :user, class_name: 'User', optional: false
  belongs_to :project, optional: false
end
