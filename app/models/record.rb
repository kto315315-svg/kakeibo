class Record < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :record_tags, dependent: :destroy
  has_many :tags, through: :record_tags

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :date, presence: true
  validates :income_or_expense, presence: true, inclusion: { in: %w[収入 支出] }
end
