class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.text :ques
      t.string :answer
      t.string :choices
      t.references :quiz, foreign_key: true
      t.timestamps
    end
  end
end
