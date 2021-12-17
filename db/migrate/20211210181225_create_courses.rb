class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.text :syllabus
      t.timestamps
    end
  end
end
