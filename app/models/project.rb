class Project < ApplicationRecord
  belongs_to :conversation
  belongs_to :person
  has_many :roles
  has_many :tasks

  accepts_nested_attributes_for :roles,
      allow_destroy: true,
      reject_if: lambda {|attr| attr["title"].blank?}

  enum state: [:inactive, :active, :complete, :cancelled]

  after_initialize :initialize_conversation

  def initialize_conversation
    if self.conversation == nil
      self.conversation = Conversation.new
    end
  end

  def has_permission(person)
      person != nil && (person.admin? || person == self.person)
  end

  def has_role?(person)
      self.roles.joins(:person_roles).where("person_roles.person_id": person.id)
  end

  def can_discuss?(person)
    self.has_role?(person)
  end
end
