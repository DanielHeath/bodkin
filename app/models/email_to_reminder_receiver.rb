class EmailToReminderReceiver < Incoming::Strategies::Postmark
  def receive(mail)
    reply_to = mail.from.addresses.first

    reminder = Reminder.create!(
      :email => reply_to,
      :when => mail.date,
      :subject => mail.subject,
      :body => mail.body.decoded,
    )

    UserMailer.reply_email(reminder).deliver
  end
end
