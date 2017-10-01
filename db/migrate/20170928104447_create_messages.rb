class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.references :person, foreign_key: true
      t.references :conversation, foreign_key: true
      t.string :message

      t.timestamps
    end
  end
end
