class CreateQas < ActiveRecord::Migration[6.1]
  def change
    create_table :qas do |t|
        t.text :content
        t.references :user, foreign_key: true
        t.references :course, foreign_key: true
        t.timestamps
    end
  end
end