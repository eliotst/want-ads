class Project < ApplicationRecord
    belongs_to :person
    has_many :roles
    has_many :tasks

    accepts_nested_attributes_for :roles,
        allow_destroy: true,
        reject_if: lambda {|attr| attr["title"].blank?}

    enum state: [:inactive, :active, :complete, :cancelled]

    def has_permission(person)
        person != nil && (person.admin? || person == self.person)
    end
end
