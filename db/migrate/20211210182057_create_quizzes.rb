class CreateQuizzes < ActiveRecord::Migration[6.1]
  def change
    create_table :quizzes do |t|
      t.references :course, foreign_key: true
      t.string :title
      t.timestamps
    end
  end
end
