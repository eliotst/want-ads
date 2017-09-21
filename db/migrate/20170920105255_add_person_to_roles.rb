class AddPersonToRoles < ActiveRecord::Migration[5.1]
  def change
    add_reference :roles, :person, foreign_key: true
  end
end
