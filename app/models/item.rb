class Item < ApplicationRecord
  has_many :item_categories
  has_many :categories, through: :item_categories
  has_many_attached :images

  validates :categories, presence: true
  validates_presence_of :title, :desc
  validates_uniqueness_of :title
  validates_numericality_of :price, greater_than: 0
end
