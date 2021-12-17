class CreateMaterials < ActiveRecord::Migration[6.1]
  def change
    create_table :materials do |t|
      t.string :material_type
      t.text :content, null: true
      t.references :course, foreign_key: true
      t.timestamps
    end
  end
end
