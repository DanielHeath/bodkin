class ReminderMailer < ActionMailer::Base
  default from: "from@bodk.in"

  def reminder_email(reminder)
    mail(
      to: reminder.email,
      subject: "Reminder: #{reminder.subject}",
      body: reminder.body
    )
  end

  def reply_email(reminder)
    mail(
      to: reminder.email,
      subject: "Got it - I'll remind you on #{reminder.when} <n/t>",
      body: ""
    )
  end
end
