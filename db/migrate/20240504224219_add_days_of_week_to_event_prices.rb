class AddDaysOfWeekToEventPrices < ActiveRecord::Migration[7.1]
  def change
    add_column :event_prices, :days_of_week, :string
  end
end
