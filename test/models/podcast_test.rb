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
require 'test_helper'

class PodcastTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
