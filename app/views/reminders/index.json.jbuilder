json.array!(@reminders) do |reminder|
  json.extract! reminder, :email, :when, :subject, :body
  json.url reminder_url(reminder, format: :json)
end
