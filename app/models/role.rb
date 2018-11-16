class Role < ApplicationRecord
  belongs_to :conversation
  belongs_to :project
  has_many :interests
  has_many :person_roles
  has_many :people, through: :person_roles

  enum role_type: [:volunteer, :organizer]

  after_initialize :initialize_conversation

  def initialize_conversation
    if self.conversation == nil
      self.conversation = Conversation.new
    end
  end

  def is_interested(person)
    self.find_interest(person).length > 0
  end

  def find_interest(person)
    self.interests.where(person: person)
  end

  def needs_people?
    self.number_of_people == nil || self.number_of_people >= self.people.length
  end

  def can_discuss(person)
    person == self.project.person || person.admin? || person == self.person
  end

  def can_assign(person)
    (person == self.project.person || role.is_project_organizer?(person) || person.admin?) && self.needs_people?
  end

  def is_project_organizer?(person)
    self.person_roles.where(person: person, role_type: Role.role_type.organizer).length > 0
  end

  def is_assigned_to?(person)
    self.person_roles.where(person: person).length > 0
  end

  def self.opportunities
    Role.where('number_of_people is null or number_of_people < person_roles_count')
  end
end
