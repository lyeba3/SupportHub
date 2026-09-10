class AddRequesterToTickets < ActiveRecord::Migration[7.2]
  def change
    add_reference :tickets, :requester,
      null: true,
      foreign_key: { to_table: :users }
  end
end