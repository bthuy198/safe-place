# frozen_string_literal: true

# class UsersLayoutController
class UsersLayoutController < ApplicationController
  layout 'users_layout/users'
  before_action :authenticate_user!

  def home; end
end
