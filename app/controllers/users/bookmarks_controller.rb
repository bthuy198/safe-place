# frozen_string_literal: true

module User
  class BookmarksController < UsersLayoutController
    before_action :authenticate_user!
    before_action :set_bookmark, only: %i[show edit update destroy]

    def index
      @bookmarks = current_user.bookmarks
    end

    def action
      Users::BookmarkService.call(current_user, params[:bookmarkable])
    end

    private

    def set_bookmark
      @bookmark = Bookmark.find_by(id: params[:id])
    end
  end
end
