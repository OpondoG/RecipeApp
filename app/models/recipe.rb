class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods

  validates :name, presence: true
  validates :preparation_time, presence: true
  validates :cooking_time, presence: true
  validates :description, presence: true
  validates :public, presence: true

  def total_price
    recipe_foods.sum { |item| item.quantity * item.food.price }
  end

  def total_quantity
    recipe_foods.count
  end
end
