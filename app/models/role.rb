class Role < ApplicationRecord
  belongs_to :project
  belongs_to :person, optional: true
  has_many :interests

  def is_interested(person)
    self.interests.any? {|interest| interest.person == person}
  end
end
