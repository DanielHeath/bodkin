require 'chronic'



class EmailToReminderReceiver

  def self.parse(str, date)
    # Oh god why
    words = str.gsub("_", " ").split(" ")

    prefixes = words.inject([]) { |arr, entry|
      arr << ((arr.last || []) + [entry])
    }.map {|e| e.join(" ") }

    prefixes.map do |prefix|
      Kronic.parse(prefix, date)
    end.reject(&:blank?).last
  end

  def self.receive(mail)
    subject = mail["Subject"]
    reply_to = mail["ReplyTo"] || mail["FromFull"]["Email"]
    date = DateTime.parse mail["Date"]
    body = mail["HtmlBody"].blank? ? mail["TextBody"] : mail["HtmlBody"]

    reminder_address = mail["ToFull"].first["Email"].split("@").first

    guessed_date = parse(reminder_address, date)
    guessed_date = parse(subject, date) if guessed_date.blank?

    reminder = Reminder.new(
      :email => reply_to,
      :when => guessed_date,
      :subject => subject,
      :body => body,
    )

    if guessed_date.blank? or guessed_date.is_a?(Range)
      ReminderMailer.error_email(reminder).deliver
    else
      reminder.save!
      ReminderMailer.reply_email(reminder).deliver
    end
  end
end
