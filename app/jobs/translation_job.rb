class TranslationJob < ApplicationJob
  queue_as :default
  
  def perform(health_record_id, target_locale, user_id = nil)
    health_record = HealthRecord.find(health_record_id)
    
    result = Translation::TranslationService.new(
      health_record: health_record,
      target_locale: target_locale
    ).call
    
    if result.success?
      Rails.logger.info "Translation completed for HealthRecord #{health_record_id} to #{target_locale}"
      # Could broadcast via ActionCable here for real-time updates
    else
      Rails.logger.error "Translation failed for HealthRecord #{health_record_id}: #{result.error}"
    end
  end
end