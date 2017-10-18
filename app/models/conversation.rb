class Conversation < ApplicationRecord
  has_many :messages
  has_one :interest
  has_one :project
  has_one :role
  has_one :task
end
