json.extract! health_record, :id, :record_type, :language, :user_id, :created_at, :updated_at
json.url health_record_url(health_record, format: :json)
