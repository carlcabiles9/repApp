# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :project, optional: false
end
