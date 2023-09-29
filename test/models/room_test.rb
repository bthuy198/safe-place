# frozen_string_literal: true

# == Schema Information
#
# Table name: rooms
#
#  id           :bigint           not null, primary key
#  name         :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  counselor_id :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_rooms_on_counselor_id  (counselor_id)
#  index_rooms_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (counselor_id => users.id)
#  fk_rails_...  (user_id => users.id)
#
require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
