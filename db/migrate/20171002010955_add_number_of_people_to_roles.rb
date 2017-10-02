class AddNumberOfPeopleToRoles < ActiveRecord::Migration[5.1]
  def change
    add_column :roles, :number_of_people, :integer
  end
end
