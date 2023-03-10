class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipes = current_user.recipes
    @user_id = current_user.id
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)

    if @recipe.save
      redirect_to recipes_path, notice: 'Recipe was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_foods = @recipe.recipe_foods.includes(:food, :recipe).order(:id)
  end

  def destroy
    @recipe = Recipe.find(params[:id])

    if @recipe.destroy
      flash[:success] = 'Recipe was successfully removed.'
    else
      flash[:error] = 'Error: Recipe could not be removed'
    end

    redirect_to user_recipes_path(user_id: current_user.id)
  end

  def recipe_params
    params.require(:recipe).permit(:user_id, :name, :preparation_time, :cooking_time, :description, :public)
  end
end
