# frozen_string_literal: true

# app/models/user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :bookings, dependent: :destroy

  ROLES = %w[admin staff customer].freeze

  after_initialize :set_default_role, if: :new_record?
  after_create :generate_otp

  def generate_otp
    self.otp = rand(100_000..999_999).to_s
    self.otp_generated_at = Time.current
    save!
    UserMailer.with(user: self).send_otp.deliver_now
  end

  def valid_otp?(input_otp)
    input_otp && otp_generated_at > 5.minutes.ago
  end

  def clear_otp
    self.otp = nil
    self.otp_generated_at = nil
    save!
  end

  def set_default_role
    self.role ||= 'customer'
  end

  def admin?
    role == 'admin'
  end

  def staff?
    role == 'staff'
  end

  def customer?
    role == 'customer'
  end
end
