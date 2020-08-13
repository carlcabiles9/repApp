# frozen_string_literal: true

class ProjectRecipient < ApplicationRecord
    belongs_to :recipient,  optional: false
    belongs_to :project, optional: false
  end
  