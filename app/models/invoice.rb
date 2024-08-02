# frozen_string_literal: true

class Invoice < ApplicationRecord
  belongs_to :booking

  validates :total_amount, :status, :issued_at, presence: true
end
