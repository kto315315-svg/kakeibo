class Category < ApplicationRecord
    has_many :records, dependent: :destroy

    validates :name, presence: true, uniqueness: true
end
