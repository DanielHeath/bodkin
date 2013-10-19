
desc "Deliver all overdue reminders"
task :deliver do
  Reminder.due.each do |reminder|
    puts "Delivering reminder #{reminder.id} to #{reminder.email}"
    UserMailer.reminder_email(reminder).deliver
    reminder.delivered = true
    reminder.save!
  end
end
