class Elevage < ApplicationRecord
  has_many :products, class_name: 'Spree::Product'

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true

  has_one_attached :image
end
