class AddDescriptionToTickets < ActiveRecord::Migration[7.2]
  def change
    add_column :tickets, :description, :text
  end
end
