# frozen_string_literal: true

json.extract! recipient, :id, :email, :user_id, :created_at, :updated_at
json.url recipient_url(recipient, format: :json)
