# frozen_string_literal: true

class RemoveLikeFromLikes < ActiveRecord::Migration[7.0]
  def up
    remove_column :likes, :like
  end

  def down
    add_column :likes, :like, :boolean
  end
end
