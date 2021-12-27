class CreateMaterials < ActiveRecord::Migration[6.1]
  def change
    create_table :materials do |t|
      t.string :material_type, null: false
      t.string :content, null: true
      t.string :name, null: false
      t.references :course, foreign_key: true
      t.timestamps
    end
  end
end
