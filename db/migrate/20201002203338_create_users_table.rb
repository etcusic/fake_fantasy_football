class CreateUsersTable < ActiveRecord::Migration[5.2]
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
  end
end

