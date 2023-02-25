class RecipeFoodsController < ApplicationController
  def new
    @recipe_food = RecipeFood.new
  end

  def create
    @recipe = current_user.recipes.find(params[:recipe_id])
    @food = current_user.foods.find(recipe_food_params[:food_id])
    @recipe_food = RecipeFood.new(recipe: @recipe, food: @food, quantity: recipe_food_params[:quantity])

    if @recipe_food.save
      flash[:success] = 'Recipe food was successfully created.'
      redirect_to user_recipe_url(current_user, @recipe)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @recipe_food = RecipeFood.find(params[:id])
  end

  def update
    @food = current_user.foods.find(recipe_food_params[:food_id])
    @recipe_food = RecipeFood.find(params[:id])
    if @recipe_food.update(food: @food, quantity: recipe_food_params[:quantity])
      flash[:success] = 'Recipe food was successfully updated.'
      redirect_to user_recipe_url(current_user, @recipe_food.recipe)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  if @recipe.destroy
    flash[:success] = 'Recipe was successfully removed.'
    redirect_to recipes_url
  else
    flash[:error] = 'Error: Recipe could not be removed'
    redirect_to user_session_url
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
end
