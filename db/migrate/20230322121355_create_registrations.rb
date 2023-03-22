class CreateRegistrations < ActiveRecord::Migration[7.0]
  def change
    create_table :registrations do |t|
      t.references :event, null: false, foreign_key: true
      t.references :spree_user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
