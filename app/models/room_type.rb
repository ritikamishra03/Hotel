class RoomType < ApplicationRecord
    has_many :rooms
    has_many :bookings, through: :rooms

    validates :name, presence:true
    validates :rate, presence:true
end