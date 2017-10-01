class AddVerifiedToInterest < ActiveRecord::Migration[5.1]
  def change
    add_column :interests, :verified, :boolean
  end
end
