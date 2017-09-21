class CreateInterests < ActiveRecord::Migration[5.1]
  def change
    create_table :interests do |t|
      t.references :role, foreign_key: true
      t.references :person, foreign_key: true

      t.timestamps
    end
  end
end
