module TranslateServices
  class TranslationService
    include ActiveModel::Model

    attr_accessor :health_record, :target_locale, :source_locale, :provider

    def initialize(attributes = {})
      super
      @provider ||= TranslateServices::Provider::GoogleTranslate.new
    end

    def call
      validate_inputs!

      raw_text = TranslateServices::TextExtractor.new(health_record: health_record).call
      return failure("No text found in document") if raw_text.blank?

      translated = provider.translate(
        text: raw_text,
        target_locale: target_locale,
        source_locale: source_locale || health_record.language
      )

      return failure("Translation provider returned empty text") if translated.blank?

      translation = health_record.translations.find_or_initialize_by(language: target_locale)
      translation.content = translated
      translation.save!

      success(translation)
    rescue => e
      Rails.logger.error "TranslationService failed for HealthRecord #{health_record&.id}: #{e.message}"
      failure(e.message)
    end

    private

    def validate_inputs!
      raise ArgumentError, "health_record is required" unless health_record
      raise ArgumentError, "target_locale is required" unless target_locale
      raise ArgumentError, "Unsupported target locale" unless supported_locale?(target_locale)
    end

    def supported_locale?(locale)
      HealthRecord::SUPPORTED_LANGUAGES.any? { |_, code| code == locale }
    end

    def success(translation)
      OpenStruct.new(success?: true, translation: translation, error: nil)
    end

    def failure(message)
      OpenStruct.new(success?: false, translation: nil, error: message)
    end
  end
end
