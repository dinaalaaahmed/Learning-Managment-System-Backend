class ChangeUserTypeDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :user_type, from: nil, to: 'guest' 
  end
end
