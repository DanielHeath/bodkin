class ReminderMailer < ActionMailer::Base
  default from: "from@bodk.in"
  default body: ""

  def reminder_email(reminder)
    mail(
      to: reminder.email,
      subject: "Reminder: #{reminder.subject}") do |format|
      format.text { render text: reminder.body }
    end
  end

  def reply_email(reminder)
    mail(
      to: reminder.email,
      subject: "Got it - I'll remind you on #{Kronic.format(reminder.when)} <n/t>") do |format|
      format.text { render text: "You'll get a reminder email at the time you asked for." }
    end

  end

  def error_email(reminder)
    mail(
      to: reminder.email,
      subject: "Not sure what time you meant by that.") do |format|
      format.text { render text: "When emailing reminder@bodk.in, start the subject line with a date, then ':', then the reminder you want." }
    end
  end
end
