json.extract! message, :id, :from_user_id, :to_user, :references, :subject, :string, :text, :string, :status, :string, :created_at, :updated_at
json.url message_url(message, format: :json)
