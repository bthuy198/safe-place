# frozen_string_literal: true

# class UsersLayoutController
class UsersLayoutController < ApplicationController
  layout 'users_layout/users'
  before_action :check_current_url

  private

  def check_current_url
    current_url = request.original_url

    if current_url.include?('confessions') && request.referer.nil?
      redirect_to root_path
      session[:confession_url] = current_url
    elsif session[:confession_url]
      session[:confession_url] = nil
    end
  end
end
