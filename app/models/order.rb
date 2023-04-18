class Order < ApplicationRecord
    belongs_to:contact
    belongs_to:address
    has_many:products
end
