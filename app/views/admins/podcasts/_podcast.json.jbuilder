# frozen_string_literal: true

json.extract! podcast, :id, :created_at, :updated_at
json.url podcast_url(podcast, format: :json)
