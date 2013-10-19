class Reminder < ActiveRecord::Base
  scope :undelivered, -> { where.not delivered: true }
  scope :due, -> { undelivered.where when: Time.at(0)..Time.now }
end
