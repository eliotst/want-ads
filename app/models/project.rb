class Project < ApplicationRecord
    belongs_to :person

    enum state: [:inactive, :active, :complete, :cancelled]
end
