class Organization < ApplicationRecord
  has_many :users, dependent: :restrict_with_error
  has_many :tickets, dependent: :restrict_with_error
end