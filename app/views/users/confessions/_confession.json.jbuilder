# frozen_string_literal: true

json.extract! confession, :id, :tag, :anonymous, :user_id, :created_at, :updated_at
json.url users_confession_path(confession, format: :json)
