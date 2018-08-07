class Dog < ApplicationRecord
  belongs_to :owner

  validates :name, :owner, presence: true
end
