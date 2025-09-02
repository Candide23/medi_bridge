module TranslateServices
  class TextExtractor
    include ActiveModel::Model
    
    attr_accessor :health_record
    
    def call
      return health_record.text_cache if health_record.text_cache.present?
      return "" unless health_record.document.attached?
      
      extracted_text = extract_text_from_document
      health_record.update(text_cache: extracted_text) if extracted_text.present?
      extracted_text
    rescue => e
      Rails.logger.error "Text extraction failed for HealthRecord #{health_record.id}: #{e.message}"
      ""
    end
    
    private
    
    def extract_text_from_document
      # Simple text extraction for now
      case health_record.document.content_type
      when /image\/(jpeg|jpg|png|gif)/
        "[DEMO OCR] Text extracted from image: #{health_record.document.filename}"
      when 'application/pdf'
        "[DEMO OCR] Text extracted from PDF: #{health_record.document.filename}"
      else
        "[DEMO] Document content"
      end
    end
  end
end