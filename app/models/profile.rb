# frozen_string_literal: true

class Profile < ApplicationRecord
  has_one_attached :avatar
  end
