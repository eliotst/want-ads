class Project < ApplicationRecord
    belongs_to :person
    has_many :roles

    accepts_nested_attributes_for :roles, allow_destroy: true, reject_if: lambda {|attr| attr["title"].blank?}

    enum state: [:inactive, :active, :complete, :cancelled]
end
