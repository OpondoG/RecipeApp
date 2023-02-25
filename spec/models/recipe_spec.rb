require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) do
    User.new(name: 'Tom')
  end

  let(:food1) do
    Food.new(
      name: 'meat',
      measurement_unit: 'kg',
      price: 10.5,
      quantity: 2
    )
  end

  let(:food2) do
    Food.new(
      name: 'fish',
      measurement_unit: 'g',
      price: 3.5,
      quantity: 6
    )
  end

  describe 'associations' do
    it { should belong_to :user }
    it { should have_many :recipe_foods }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:preparation_time) }
    it { should validate_presence_of(:cooking_time) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:public) }
  end

  describe '#total_price' do
    it 'returns the correct total price' do
      recipe = Recipe.new(user:)
      recipe.recipe_foods.build(food: food1, quantity: 2)
      recipe.recipe_foods.build(food: food2, quantity: 3)
      expected_total_price = (2 * food1.price) + (3 * food2.price)
      expect(recipe.total_price).to eq(expected_total_price)
    end
  end

  describe '#total_quantity' do
    it 'returns the correct total quantity' do
      recipe = Recipe.new(
        user:,
        name: 'My Recipe',
        preparation_time: 10,
        cooking_time: 20,
        description: 'A delicious recipe',
        public: true
      )
      recipe.save
      recipe.recipe_foods.create(food: food1, quantity: 2)
      recipe.recipe_foods.create(food: food2, quantity: 3)
      expect(recipe.total_quantity).to eq(recipe.recipe_foods.count)
    end
  end
end
