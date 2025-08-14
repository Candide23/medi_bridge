class HealthRecord < ApplicationRecord
    belongs_to :user
    has_many :translations, dependent: :destroy
      has_one_attached :document

        validate :document_type_and_size



  enum record_type: { prescription: 0, vaccination: 1, doctor_note: 2, other: 3 }

  validates :record_type, :language, presence: true

    private
  def document_type_and_size
    return unless document.attached?

    allowed = %w[application/pdf image/png image/jpeg image/jpg text/plain]
    errors.add(:document, "must be PDF, image, or text") unless allowed.include?(document.content_type)
    errors.add(:document, "must be < 25 MB") if document.byte_size > 25.megabytes
  end
  
end
