# frozen_string_literal: true

# == Schema Information
#
# Table name: podcast_albums
#
#  id         :bigint           not null, primary key
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
require 'test_helper'

class PodcastAlbumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
