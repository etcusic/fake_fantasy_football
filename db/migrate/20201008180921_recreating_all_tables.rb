class RecreatingAllTables < ActiveRecord::Migration[5.2]
  def change

      create_table :users do |t|
        t.string :name
        t.string :username
        t.string :password
        t.string :photo_url
        t.string :ssn
        t.string :credit_card_info
        t.string :deepest_darkest_secret
        t.string :what_you_want_for_christmas
      end
  
      create_table :teams do |t|
        t.string :name
        t.string :location
        t.string :slogan
        t.string :logo
        t.integer :wins
        t.integer :losses
        t.integer :user_id
      end
  
      create_table "players", force: :cascade do |t|
        t.string "name"
        t.string "school"
        t.string "position"
        t.boolean "available"
        t.integer "team_id"
      end

  end
end
