class Owner < ApplicationRecord
    has_many :dogs

    validates :name, length: { minimum: 2 }
    validates :phone_number, presence: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :email, uniqueness: true
end
