class HealthRecord < ApplicationRecord
  belongs_to :user
  has_many :translations, dependent: :destroy
  has_one_attached :document, dependent: :purge_later

  RECORD_TYPES = [
    "Lab Result",
    "Prescription",
    "Immunization",
    "Visit Summary",
    "Imaging",
    "Allergy",
    "Referral",
    "Insurance"
  ].freeze

  # Updated to use ISO language codes for better translation compatibility
  SUPPORTED_LANGUAGES = [
    ['English', 'en'],
    ['French', 'fr'],
    ['Spanish', 'es'],
    ['Portuguese', 'pt'],
    ['Arabic', 'ar'],
    ['Chinese (Simplified)', 'zh'],
    ['Lingala', 'ln'],  # Note: May have limited translation support
    ['Swahili', 'sw']
  ].freeze

  validates :record_type, :language, presence: true
  validates :language, inclusion: { in: SUPPORTED_LANGUAGES.map(&:last) }
  validate :document_type_and_size

  # Translation helper methods
  def translation_for(language_code)
    translations.find_by(language: language_code)
  end

  def has_translation?(language_code)
    translations.exists?(language: language_code)
  end

  def language_name
    SUPPORTED_LANGUAGES.find { |_, code| code == language }&.first || language
  end

  def available_translation_languages
    translations.pluck(:language)
  end

  # Check if document needs OCR
  def needs_ocr?
    return false unless document.attached?
    
    case document.content_type
    when /image\/(jpeg|jpg|png|gif)/
      true
    when 'application/pdf'
      true
    else
      false
    end
  end

  private

  def document_type_and_size
    return unless document.attached?
    
    allowed = %w[application/pdf image/png image/jpeg image/jpg text/plain]
    errors.add(:document, "must be PDF, image, or text") unless allowed.include?(document.content_type)
    errors.add(:document, "must be < 25 MB") if document.byte_size > 25.megabytes
  end
end
