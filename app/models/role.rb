class Role < ApplicationRecord
  belongs_to :conversation
  belongs_to :project
  has_many :interests
  has_many :person_roles
  has_many :people, through: :person_roles

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
    self.number_of_people > self.people.length
  end

  def can_discuss(person)
    person == self.project.person || person.admin? || person == self.person
  end

  def can_assign(person)
    (person == self.project.person || person.admin?) && self.needs_people?
  end
end
