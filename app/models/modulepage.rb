class Modulepage < ApplicationRecord
    has_and_belongs_to_many :roles
    validates :name, uniqueness: true, presence: true
    validates :url, uniqueness: true, presence: true
end
