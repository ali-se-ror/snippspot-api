require 'rails_helper'
require 'database_cleaner/active_record'
DatabaseCleaner.strategy = :truncation

RSpec.describe Review, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:description) }
  end

  describe 'associations' do
    it { should belong_to(:spot) }
  end
  DatabaseCleaner.clean
end
