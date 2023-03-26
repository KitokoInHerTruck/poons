class AddReferencesToAttendances < ActiveRecord::Migration[7.0]
  def change
    add_reference :attendances, :event, null: false, foreign_key: true
    add_reference :attendances, :spree_user, null: false, foreign_key: { to_table: :spree_users }
  end
end

