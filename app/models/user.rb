class User < ApplicationRecord
  belongs_to :organization
  has_many :comments, dependent: :restrict_with_error

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :role, presence: true

  has_many :requested_tickets,
         class_name: "Ticket",
         foreign_key: :requester_id,
         dependent: :restrict_with_error
  def owner_of?(organization)
    self.organization_id == organization.id && role == "owner"
  end
end