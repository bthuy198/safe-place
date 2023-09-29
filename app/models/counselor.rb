# frozen_string_literal: true

# Class Counselor
class Courselor < User
  has_many :schedules, dependent: :destroy
  has_many :rooms, dependent: :nullify
end
