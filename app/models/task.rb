class Task < ApplicationRecord
  belongs_to :project
  belongs_to :person, optional: true
  belongs_to :role, optional: true
  belongs_to :conversation

  after_initialize :initialize_conversation

  enum status: [:incomplete, :complete]

  def initialize_conversation
    if self.conversation == nil
      self.conversation = Conversation.new
    end
  end

  def assignee_name
    @task.try(:person).try(:full_name) || @task.try(:role).try(:title) || 'No One'
  end
end
