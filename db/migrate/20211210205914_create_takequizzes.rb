class CreateTakequizzes < ActiveRecord::Migration[6.1]
  def change
    create_table :takequizzes do |t|
      t.integer :grade
      t.references :user, foreign_key: true
      t.references :quiz, foreign_key: true
      t.timestamps
    end
  end
end
