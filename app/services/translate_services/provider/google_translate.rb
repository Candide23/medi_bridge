module TranslateServices
  module Provider
    class GoogleTranslate
      def initialize(client: nil)
        key = ENV['GOOGLE_TRANSLATE_API_KEY']
        raise "Missing GOOGLE_TRANSLATE_API_KEY" if key.blank?

        @client = client || ::Google::Cloud::Translate::V2.new(key: key)
      end

      def translate(text:, target_locale:, source_locale: nil)
        to   = map_locale(target_locale)
        from = map_locale(source_locale) if source_locale.present?

        res = @client.translate(text, to: to, from: from)
        res = res.first if res.is_a?(Array)
        res&.text.to_s
      end

      private

      # Normalize a few common locales
      def map_locale(locale)
        return nil if locale.blank?
        case locale.to_s.downcase
        when 'zh', 'zh-cn' then 'zh-CN'
        when 'zh-tw'       then 'zh-TW'
        else locale.to_s
        end
      end
    end
  end
end
