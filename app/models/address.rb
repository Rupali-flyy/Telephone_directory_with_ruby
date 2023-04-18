class Address < ApplicationRecord
    belongs_to:contact
    has_many:orders
end
