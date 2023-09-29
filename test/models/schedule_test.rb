# frozen_string_literal: true

# == Schema Information
#
# Table name: schedules
#
#  id           :bigint           not null, primary key
#  date         :date
#  end_time     :datetime
#  start_time   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  counselor_id :bigint           not null
#  user_id      :bigint
#
# Indexes
#
#  index_schedules_on_counselor_id  (counselor_id)
#  index_schedules_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (counselor_id => users.id)
#  fk_rails_...  (user_id => users.id)
#
require 'test_helper'

class ScheduleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
