
desc "Deliver all overdue reminders"
task :deliver => :environment do
  Rails.application.eager_load!
  Reminder.due.each do |reminder|
    puts "Delivering reminder #{reminder.id} to #{reminder.email}"
    ReminderMailer.reminder_email(reminder).deliver
    reminder.delivered = true
    reminder.save!
  end
end
