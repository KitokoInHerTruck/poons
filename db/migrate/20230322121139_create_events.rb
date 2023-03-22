class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :strat_date
      t.integer :duration
      t.integer :price
      t.string :location

      t.timestamps
    end
  end
end
