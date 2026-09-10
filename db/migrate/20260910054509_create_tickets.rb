class CreateTickets < ActiveRecord::Migration[7.2]
  def change
    create_table :tickets do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :subject, null: false, limit: 160
      t.string :status, null: false, default: "open"
      t.integer :priority, null: false, default: 0
      t.datetime :resolved_at
      t.timestamps
    end

    add_index :tickets, [:organization_id, :status, :created_at],
      name: "index_tickets_for_queue"

    add_check_constraint :tickets,
      "status IN ('open', 'waiting', 'resolved')",
      name: "tickets_status_allowed"
  end
end