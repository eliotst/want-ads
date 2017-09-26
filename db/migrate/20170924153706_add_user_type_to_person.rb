class AddUserTypeToPerson < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :user_type, :integer
  end
end
