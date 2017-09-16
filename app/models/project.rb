class Project < ApplicationRecord
    enum state: [:inactive, :active, :complete, :cancelled]
end
