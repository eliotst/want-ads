class AddPasswordSaltToPerson < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :password_salt, :string
  end
end
