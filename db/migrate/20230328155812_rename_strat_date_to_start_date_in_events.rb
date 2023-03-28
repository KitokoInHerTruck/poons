class RenameStratDateToStartDateInEvents < ActiveRecord::Migration[7.0]
  def change
    rename_column :events, :strat_date, :start_date
  end
end
