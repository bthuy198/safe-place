# frozen_string_literal: true

module Users
  class BookmarkService < ApplicationService
    def initialize(user, bookmarkable)
      @user = user
      @bookmarkable = bookmarkable
    end

    def call
      if exists?
        destroy
      else
        create
      end
    end

    def create
      @user.bookmarks.create(bookmarkable: @bookmarkable, anonymous: @user.anonymous)
    end

    def destroy
      bookmark = @user.bookmarks.find_by(bookmarkable: @bookmarkable)
      bookmark&.destroy
    end

    def exists?
      @user.bookmarks.exists?(bookmarkable: @bookmarkable)
    end
  end
end
