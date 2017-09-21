class AddPersonToProjects < ActiveRecord::Migration[5.1]
  def change
    add_reference :projects, :person, foreign_key: true
  end
end
