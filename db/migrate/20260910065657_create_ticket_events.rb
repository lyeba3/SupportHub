class CreateTicketEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :ticket_events do |t|
      t.references :ticket, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :event_type
      t.text :metadata

      t.timestamps
    end
  end
end
