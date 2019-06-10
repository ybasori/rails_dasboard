class Role < ApplicationRecord
    has_and_belongs_to_many :modulepages
    validates :name, uniqueness: true, presence: true
    validates :alias, uniqueness: true, presence: true
end
