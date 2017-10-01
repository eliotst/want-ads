class Interest < ApplicationRecord
  belongs_to :conversation
  belongs_to :role
  belongs_to :person
  belongs_to :verification_token, optional: true

  after_initialize :initialize_conversation

  def initialize_conversation
    if self.conversation == nil
      self.conversation = Conversation.new
    end
  end
end
