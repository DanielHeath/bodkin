class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.string :email
      t.datetime :when
      t.string :subject
      t.text :body

      t.timestamps
    end
  end
end
