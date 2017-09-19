class CreatePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :people do |t|
      t.string :email
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
