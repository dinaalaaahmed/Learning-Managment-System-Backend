class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :user_name, unique: true
      t.string :password_digest
      t.text :email, unique: true
      t.string :first_name, null: true
      t.string :last_name, null: true
      t.string :birth_date, null: true
      t.string :user_type
      t.timestamps 
    end
  end
end
