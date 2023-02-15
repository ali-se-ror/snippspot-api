class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :spots

  def authenticate(email, password)
    user = User.find_for_authentication(email:)
    user.valid_password?(password) ? user : nil
  end
end
