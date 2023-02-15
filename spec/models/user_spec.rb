# frozen_string_literal: true

require 'rails_helper'
require 'database_cleaner/active_record'
DatabaseCleaner.strategy = :truncation

RSpec.describe User, type: :model do
  describe 'authenticate' do
    let(:user) { User.create!(email: 'abc@test.com', password: 'password') }

    it 'returns user if valid email and password' do
      expect(user.authenticate('abc@test.com', 'password')).to eq user
    end

    it 'returns nil if invalid email and password' do
      expect(user.authenticate('abc@test.com', 'pass')).to eq nil
    end
  end
  DatabaseCleaner.clean
end
