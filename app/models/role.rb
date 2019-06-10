class Role < ApplicationRecord
    has_and_belongs_to_many :modulepages
    has_and_belongs_to_many :users
    validates :name, uniqueness: true, presence: true
    validates :alias, uniqueness: true, presence: true
end
