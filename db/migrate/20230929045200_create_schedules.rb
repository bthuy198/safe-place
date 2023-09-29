# frozen_string_literal: true

# class CreateSchedules
class CreateSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.date :date
      t.references :user, foreign_key: { to_table: :users }, null: true
      t.references :counselor, foreign_key: { to_table: :users }, null: false

      t.timestamps
    end
  end
end
