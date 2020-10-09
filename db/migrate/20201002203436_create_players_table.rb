class CreatePlayersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :name
      t.string :school
      t.string :position
      t.integer :team_id
      t.boolean :active
    end
  end
end
