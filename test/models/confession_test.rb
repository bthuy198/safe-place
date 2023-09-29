# frozen_string_literal: true

# == Schema Information
#
# Table name: confessions
#
#  id         :bigint           not null, primary key
#  anonymous  :boolean
#  tag        :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_confessions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'test_helper'

class ConfessionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
