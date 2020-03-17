# frozen_literal_string: true

# Registration is modelling all the data for the registration of a user(~freelancer).
# It tracks email confirmation
class Registration < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  has_one :request
  has_one :user

  validates_presence_of :name, :bio
  validates :email, format: { with: Devise.email_regexp }
  validates :bio, length: { minimum: 25 }
  validates :phone, phone: {
    possible: true,
    allow_blank: false,
    types: [:voip, :mobile],
    countries: %i[FR NL ES GR]
  }

  def after_confirmation
    request.confirmed!
  end
end
