module TranslateServices
  module Provider
    class GoogleTranslate
      include ActiveModel::Model
      
      def translate(text:, target_locale:, source_locale: nil)
        return demo_translation(text) unless credentials_available?
        
        begin
          result = translate_client.translate(text, {
            to: target_locale,
            from: source_locale
          }.compact)
          
          result.text
        rescue => e
          Rails.logger.error "Translation failed: #{e.class} - #{e.message}"
          demo_translation(text)
        end
      end
      
      private
      
      def credentials_available?
        ENV['GOOGLE_TRANSLATE_API_KEY'].present? || 
        (ENV['GOOGLE_PROJECT_ID'].present? && ENV['GOOGLE_APPLICATION_CREDENTIALS'].present?)
      end
      
      def translate_client
        @translate_client ||= begin
          if ENV['GOOGLE_TRANSLATE_API_KEY'].present?
            Google::Cloud::Translate.translation_v2_service(
              key: ENV['GOOGLE_TRANSLATE_API_KEY']
            )
          else
            Google::Cloud::Translate.translation_v2_service(
              project_id: ENV['GOOGLE_PROJECT_ID'],
              credentials: ENV['GOOGLE_APPLICATION_CREDENTIALS']
            )
          end
        end
      end
      
      def demo_translation(text)
        "[DEMO TRANSLATION] #{text}"
      end
    end
  end
end