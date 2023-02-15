require 'rails_helper'
require 'database_cleaner/active_record'
DatabaseCleaner.strategy = :truncation

RSpec.describe Spot, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:location) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
  DatabaseCleaner.clean
end
