# frozen_string_literal: true

# == Schema Information
#
# Table name: course_sessions
#
#  id             :bigint           not null, primary key
#  description    :string(255)
#  image          :string(255)
#  name           :string(255)      not null
#  session_number :integer
#  video          :string(255)      not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  course_id      :bigint           not null
#
# Indexes
#
#  index_course_sessions_on_course_id  (course_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_id => courses.id)
#
require 'test_helper'

class CourseSessionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
