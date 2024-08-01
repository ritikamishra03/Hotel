class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.string :room_number, null: false
      t.references :room_type, null: false, foreign_key: true
      t.string :status, default:'clean'

      t.timestamps
    end
  end
end