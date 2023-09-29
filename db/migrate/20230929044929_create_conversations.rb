# frozen_string_literal: true

# class CreateConversations
class CreateConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :conversations do |t|
      t.references :room, null: false, foreign_key: true
      t.references :conversationable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
