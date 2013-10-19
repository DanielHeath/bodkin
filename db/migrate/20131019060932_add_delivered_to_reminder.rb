class AddDeliveredToReminder < ActiveRecord::Migration
  def change
    add_column :reminders, :delivered, :bool, :null => false, :default => false
  end
end
