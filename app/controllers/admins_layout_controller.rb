# frozen_string_literal: true

# Class AdminsController
class AdminsLayoutController < ApplicationController
  layout 'admins_layout/admins'
  before_action :authenticate_admin!
end
