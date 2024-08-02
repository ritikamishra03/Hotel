# frozen_string_literal: true

class CreateRoomTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :room_types do |t|
      t.string :name, null: false
      t.decimal :rate, precision: 10, scale: 2

      t.timestamps
    end
  end
end
