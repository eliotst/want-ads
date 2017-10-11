class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.integer :status
      t.references :project, foreign_key: true
      t.references :person, foreign_key: true
      t.references :role, foreign_key: true
      t.references :conversation, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
