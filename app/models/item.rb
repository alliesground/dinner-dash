class Item < ApplicationRecord
  has_many :item_categories
  has_many :categories, through: :item_categories

  validates :categories, presence: true
end
