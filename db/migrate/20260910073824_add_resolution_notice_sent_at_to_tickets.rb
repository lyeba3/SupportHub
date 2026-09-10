class AddResolutionNoticeSentAtToTickets < ActiveRecord::Migration[7.2]
  def change
    add_column :tickets, :resolution_notice_sent_at, :datetime
  end
end
