class CreateVerificationTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :verification_tokens do |t|
      t.string :token
      t.references :person, foreign_key: true
      t.datetime :expires_at

      t.timestamps
    end
  end
end
