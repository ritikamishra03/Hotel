# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(
      email: 'test@example.com',
      password: 'password',
      password_confirmation: 'password',
      name: 'Test User',
      role: 'customer'
    )
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not  valid without an email' do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a password' do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid  with  a duplicate email' do
      User.create!(email: 'test@example.com', password: 'password', name: 'Test User')
      expect(subject).to_not be_valid
    end

    it 'is valid with a valid role' do
      subject.role = 'admin'
      expect(subject).to be_valid
    end
  end

  describe 'Database  Constraints' do
    it 'has a unique email' do
      duplicate_user = subject.dup
      subject.save
      expect(duplicate_user).to_not be_valid
    end

    it 'cannot save a user without email' do
      expect do
        described_class.create!(password: 'password', name: 'Test  User')
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'Instance Methods' do
    it 'returns the full name' do
      expect(subject.name).to eq('Test User')
    end
  end
end
