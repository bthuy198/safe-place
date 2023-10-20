# frozen_string_literal: true

module Users
  # class Comments Controller
  class CommentsController < UsersLayoutController

    def index
      respond_to do |format|
        format.html
        format.turbo_stream
      end
    end

  end
end
