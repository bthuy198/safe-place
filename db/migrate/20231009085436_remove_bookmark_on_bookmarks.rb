# frozen_string_literal: true

class RemoveBookmarkOnBookmarks < ActiveRecord::Migration[7.0]
  def change
    remove_column :bookmarks, :bookmark
  end
end
