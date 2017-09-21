class Person < ApplicationRecord
    has_many :projects

    def full_name
        self.first_name + " " + self.last_name
    end
end
