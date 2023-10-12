# frozen_string_literal: true

# == Schema Information
#
# Table name: podcasts
#
#  id               :bigint           not null, primary key
#  audio            :string(255)      not null
#  author_name      :string(255)
#  episode_number   :integer
#  image            :string(255)
#  name             :string(255)      not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  podcast_album_id :bigint           not null
#
# Indexes
#
#  index_podcasts_on_podcast_album_id  (podcast_album_id)
#
# Foreign Keys
#
#  fk_rails_...  (podcast_album_id => podcast_albums.id)
#
class Podcast < ApplicationRecord
  belongs_to :podcast_album
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :bookmarks, as: :bookmarkable, dependent: :destroy
  validates :audio, presence: true

  mount_uploader :audio, AudioUploader
  mount_uploader :image, ImageUploader
end
