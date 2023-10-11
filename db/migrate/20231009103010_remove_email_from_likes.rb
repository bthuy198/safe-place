# frozen_string_literal: true

class RemoveEmailFromLikes < ActiveRecord::Migration[7.0]
  def change
    remove_column :likes, :like, :boolean
  end
end
