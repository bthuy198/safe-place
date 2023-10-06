# frozen_string_literal: true

# == Schema Information
#
# Table name: podcast_albums
#
#  id         :bigint           not null, primary key
#  image      :string(255)
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_podcast_albums_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class PodcastAlbum < ApplicationRecord
  belongs_to :user
  has_many :podcasts, dependent: :destroy
  max_paginates_per 10
  mount_uploader :image, ImageUploader
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "image", "name", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["podcasts", "user"]
  end
end
