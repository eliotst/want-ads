class RemovePersonFromRole < ActiveRecord::Migration[5.1]
  def change
    remove_reference :roles, :person, foreign_key: true
  end
end
