class ReminderMailer < ActionMailer::Base
  include ActionView::Helpers::DateHelper

  default from: "reminder@bodk.in"

  def reminder_email(reminder)
    mail(
      to: reminder.email,
      subject: "Reminder: #{reminder.subject}") do |format|
      format.html { render text: reminder.body }
      format.text { render text: reminder.body }
    end
  end

  def reply_email(reminder)
    mail(
      to: reminder.email,
      subject: "Got it - I'll remind you in #{distance_of_time_in_words_to_now reminder.when} <n/t>") do |format|
      format.text { render text: "You'll get a reminder email at #{reminder.when}." }
    end
  end

  def error_email(reminder, subject)
    mail(
      to: reminder.email,
      subject: "Not sure what time you meant by '#{subject}'.") do |format|
      format.text { render text: "When emailing reminder@bodk.in, start the subject line with a date, then ':', then the reminder you want." }
    end
  end

  def already_past_email(reminder, subject)
    mail(
      to: reminder.email,
      subject: "'#{subject}' is in the past.") do |format|
      format.text { render text: "It looks like '#{subject}' means #{reminder.when} which is #{distance_of_time_in_words_to_now reminder.when} ago." }
    end
  end
end
