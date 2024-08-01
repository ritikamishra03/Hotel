class Room < ApplicationRecord
    belongs_to :room_type
    has_many :bookings

    validates :room_number, presence:true, uniqueness:true
    validates :status, presence: true

    STATUSES = %w[clean occupied maintenace]
    

    def available?
        status==clean
    end
end