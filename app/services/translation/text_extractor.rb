module Translation
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
      Rails.logger.error "Text extraction failed for HealthRecord #{health_record.id}: #{e.class} - #{e.message}"
      ""
    end
    
    private
    
    def extract_text_from_document
      content_type = health_record.document.content_type
      
      case content_type
      when /image\/(jpeg|jpg|png|gif)/
        extract_from_image
      when 'application/pdf'
        extract_from_pdf
      else
        ""
      end
    end
    
    def extract_from_image
      health_record.document.open do |file|
        RTesseract.new(file.path).to_s.strip
      end
    end
    
    def extract_from_pdf
      # Try PDF text extraction first, fallback to OCR
      begin
        text = extract_text_from_pdf_reader
        return text if text.present? && text.length > 50 # Reasonable threshold
      rescue
        Rails.logger.info "PDF text extraction failed, falling back to OCR"
      end
      
      # Fallback to OCR
      extract_pdf_via_ocr
    end
    
    def extract_text_from_pdf_reader
      health_record.document.open do |file|
        reader = PDF::Reader.new(file.path)
        text = reader.pages.map(&:text).join("\n").strip
        text
      end
    end
    
    def extract_pdf_via_ocr
      health_record.document.open do |file|
        RTesseract.new(file.path).to_s.strip
      end
    end
  end
end