# frozen_string_literal: true

# class UsersLayoutController
class UsersLayoutController < ApplicationController
  layout 'users_layout/users'
  before_action :check_current_url

  private

  def check_current_url
    current_url = request.original_url

    conditions = [
      { keywords: ['confession'], session_key: :confession_url },
      { keywords: ['album', 'podcast'], session_key: :podcast_url }
    ]

    conditions.each do |condition|
      if condition[:keywords].any? { |keyword| current_url.include?(keyword) } && request.referer.nil?
        redirect_to root_path
        session[condition[:session_key]] = current_url
      elsif session[condition[:session_key]]
        session[condition[:session_key]] = nil
      end
    end
  end
end
