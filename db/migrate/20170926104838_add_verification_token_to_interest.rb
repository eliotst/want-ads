class AddVerificationTokenToInterest < ActiveRecord::Migration[5.1]
  def change
    add_reference :interests, :verification_token, foreign_key: true
  end
end
