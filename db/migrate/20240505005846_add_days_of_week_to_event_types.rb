class AddDaysOfWeekToEventTypes < ActiveRecord::Migration[7.1]
  def change
    add_column :event_types, :days_of_week, :text
  end
end
