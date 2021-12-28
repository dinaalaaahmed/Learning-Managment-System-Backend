class CreateFile < ActiveRecord::Migration[6.1]
  def change
    create_table :files do |t|

      t.timestamps
    end
  end
end
