module TranslationsHelper
  def language_name(language_code)
    HealthRecord::SUPPORTED_LANGUAGES.find { |name, code| code == language_code }&.first || language_code
  end
  
  def language_options
    options_for_select(HealthRecord::SUPPORTED_LANGUAGES)
  end
end