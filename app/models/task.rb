class Task < ApplicationRecord
  belongs_to :project
  belongs_to :person, optional: true
  belongs_to :role, optional: true
  belongs_to :conversation
  belongs_to :parent, class_name: "Task", optional: true
  has_many :subtasks, class_name: "Task", foreign_key: "parent_id"

  after_initialize :initialize_conversation

  enum status: [:incomplete, :complete]

  def initialize_conversation
    self.conversation ||= Conversation.new
    self.status ||= "incomplete"
  end

  def assignee_name
    self.try(:person).try(:full_name) || self.try(:role).try(:title) || 'No One'
  end

  def can_discuss?(person)
    self.project.has_role?(person)
  end

  def has_permission?(person)
    self.person == person || self.project.has_permission(person)
  end

  def is_eligible?(person)
    self.person == nil && self.role != nil && self.role.is_assigned_to?(person)
  end
end
