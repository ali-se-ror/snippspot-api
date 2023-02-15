require 'rails_helper'
require 'database_cleaner/active_record'
DatabaseCleaner.strategy = :truncation

RSpec.describe Review, type: :model do
  let(:user) { User.create!(email: 'abc@test.com', password: 'password') }
  let(:spot) { Spot.create!(title: 'Test Spot', description: 'Test Spot Description', location: 'UK', user_id: user.id, price: 80) }
  subject {
    Review.create!(description: 'Review Description',
                   rating: 3,
                   spot_id: spot.id)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a description" do
    subject.description = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a spot_id" do
    subject.spot_id = nil
    expect(subject).to_not be_valid
  end

  DatabaseCleaner.clean
end
