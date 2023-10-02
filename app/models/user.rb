# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  anonymous              :boolean          default(FALSE)
#  confirmation_sent_at   :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string(255)
#  deleted_at             :datetime
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  failed_attempts        :integer          default(0), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string(255)
#  locked_at              :datetime
#  phone_number           :string(255)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  sign_in_count          :integer          default(0), not null
#  status                 :string(255)      default(NULL)
#  type                   :string(255)      default("User")
#  unconfirmed_email      :string(255)
#  unlock_token           :string(255)
#  user_name              :string(255)      not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_deleted_at            (deleted_at)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable
  has_many :conversations, as: :conversationable, dependent: :nullify
  has_many :bookmarks, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :confessions, dependent: :destroy
  has_many :enrollments, dependent: :nullify
  has_many :podcast_albums, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many :schedules, dependent: :nullify
  has_many :session_states, dependent: :destroy
  has_one :user_info, dependent: :destroy

  enum status: { available: 'Available', unavailable: 'Unavailable', await: 'Await' }
end
