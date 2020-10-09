class FineTuningAllTables < ActiveRecord::Migration[5.2]

  def change
    drop_table :users
    drop_table :teams
    drop_table :players
  end
end
