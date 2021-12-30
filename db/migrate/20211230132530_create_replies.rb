class CreateReplies < ActiveRecord::Migration[6.1]
  def change
    create_table :replies do |t|
      t.text :content
      t.references :user, foreign_key: true
      t.references :qa, foreign_key: true
      t.timestamps
    end
  end
end