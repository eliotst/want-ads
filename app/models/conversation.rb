class Conversation < ApplicationRecord
  has_many :messages
  has_one :interest
  has_one :role
end
