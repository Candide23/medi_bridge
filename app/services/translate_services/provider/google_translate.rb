require 'google/cloud/translate/v2'

module TranslateServices
  module Provider
    class GoogleTranslate
      include ActiveModel::Model
      
      def translate(text:, target_locale:, source_locale: nil)
        return demo_translation(text, target_locale) unless credentials_available?
        return demo_translation(text, target_locale) if target_locale.blank?
        
        begin
          # Clean the text for translation
          clean_text = text.gsub(/\[DEMO OCR\]\s*/, '').strip
          
          translate_params = { to: target_locale }
          translate_params[:from] = source_locale if source_locale.present?
          
          result = translate_client.translate(clean_text, translate_params)
          result.text
        rescue => e
          Rails.logger.error "Translation failed: #{e.message}"
          demo_translation(text, target_locale)
        end
      end
      
      private
      
      def credentials_available?
        ENV['GOOGLE_TRANSLATE_API_KEY'].present?
      end
      
      def translate_client
        @translate_client ||= Google::Cloud::Translate::V2.new(
          key: ENV['GOOGLE_TRANSLATE_API_KEY']
        )
      end
      
      def demo_translation(text, target_locale)
        "[DEMO TRANSLATION to #{target_locale}] #{text}"
      end
    end
  end
end