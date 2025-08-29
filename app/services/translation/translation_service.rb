module Translation
  class TranslationService
    include ActiveModel::Model
    
    attr_accessor :health_record, :target_locale, :source_locale, :provider
    
    def initialize(attributes = {})
      super
      @provider ||= Provider::GoogleTranslate.new
    end
    
    def call
      validate_inputs!
      
      # Extract text from document
      text_content = extract_text
      return failure("No text found in document") if text_content.blank?
      
      # Translate text
      translated_text = translate_text(text_content)
      
      # Create or update translation record
      translation = find_or_create_translation(translated_text)
      
      success(translation)
    rescue => e
      Rails.logger.error "TranslationService failed for HealthRecord #{health_record.id}: #{e.message}"
      failure(e.message)
    end
    
    private
    
    def validate_inputs!
      raise ArgumentError, "health_record is required" unless health_record
      raise ArgumentError, "target_locale is required" unless target_locale
      raise ArgumentError, "Unsupported target locale" unless supported_locale?(target_locale)
    end
    
    def extract_text
      TextExtractor.new(health_record: health_record).call
    end
    
    def translate_text(text)
      provider.translate(
        text: text,
        target_locale: target_locale,
        source_locale: source_locale || health_record.language
      )
    end
    
    def find_or_create_translation(translated_text)
      health_record.translations.find_or_initialize_by(language: target_locale).tap do |translation|
        translation.content = translated_text
        translation.save!
      end
    end
    
    def supported_locale?(locale)
      SUPPORTED_LANGUAGES.any? { |_, code| code == locale }
    end
    
    def success(translation)
      OpenStruct.new(success?: true, translation: translation, error: nil)
    end
    
    def failure(message)
      OpenStruct.new(success?: false, translation: nil, error: message)
    end
  end
end