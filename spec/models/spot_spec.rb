require 'rails_helper'
require 'database_cleaner/active_record'
DatabaseCleaner.strategy = :truncation

RSpec.describe Spot, type: :model do
  let(:user) { User.create!(email: 'abc@test.com', password: 'password') }
  subject {
    Spot.create!(title: "Test Spot",
                description: 'Test Spot Description',
                price: 70,
                location: 'UK',
                user_id: user.id)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a price" do
    subject.price = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a location" do
    subject.location = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a user_id" do
    subject.user_id = nil
    expect(subject).to_not be_valid
  end
  DatabaseCleaner.clean
end
