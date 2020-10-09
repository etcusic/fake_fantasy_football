class CreateTeamsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :location
      t.string :slogan
      t.string :logo_url
      t.integer :wins
      t.integer :losses
      t.integer :user_id
    end
  end
end
