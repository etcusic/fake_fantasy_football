class ReloadDbAgain < ActiveRecord::Migration[5.2]
  def down
    drop_table :users
    drop_table :teams
    drop_table :players
  end

  def up
    create_table "players", force: :cascade do |t|
      t.string "name"
      t.string "school"
      t.string "position"
      t.boolean "available"
      t.integer "team_id"
    end

    create_table "teams", force: :cascade do |t|
      t.string "name"
      t.string "location"
      t.string "slogan"
      t.string "logo"
      t.integer "wins"
      t.integer "losses"
      t.integer "user_id"
    end

    create_table "users", force: :cascade do |t|
      t.string "name"
      t.string "username"
      t.string "password_digest"
      t.string "photo_url"
      t.string "ssn"
      t.string "credit_card_info"
      t.string "deepest_darkest_secret"
      t.string "what_you_want_for_christmas"
    end
  end
end
