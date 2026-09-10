class TicketEvent < ApplicationRecord
  belongs_to :ticket
  belongs_to :user

  validates :event_type, presence: true
end