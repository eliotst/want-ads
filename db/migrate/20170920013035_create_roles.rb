class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.string :title
      t.string :description
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
