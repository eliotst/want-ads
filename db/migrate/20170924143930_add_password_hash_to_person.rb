class AddPasswordHashToPerson < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :password_hash, :string
  end
end
