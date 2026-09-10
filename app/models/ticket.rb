class Ticket < ApplicationRecord
  STATUSES = %w[open waiting resolved].freeze

  belongs_to :organization
  belongs_to :requester, class_name: "User", optional: true
  has_many :comments, dependent: :destroy
  has_many :ticket_events, dependent: :destroy
  has_one_attached :attachment
  validates :subject, presence: true, length: { maximum: 160 }
  validates :status, inclusion: { in: STATUSES }

  scope :urgent_first, -> { order(priority: :desc, created_at: :asc) }
  scope :unresolved, -> { where.not(status: "resolved") }

  validate :attachment_must_be_pdf

  private

  def attachment_must_be_pdf
    return unless attachment.attached?

    unless attachment.content_type == "application/pdf"
    errors.add(:attachment, "must be a PDF")
  end
 end
end