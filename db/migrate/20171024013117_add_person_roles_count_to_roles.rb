class AddPersonRolesCountToRoles < ActiveRecord::Migration[5.1]
  def change
    add_column :roles, :person_roles_count, :integer
  end
end
