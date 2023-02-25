class FoodsController < ApplicationController
  before_action :authenticate_user!

  def index
    @foods = current_user.foods
  end

  def new
    @food = Food.new
  end

  def create
    @food = current_user.foods.new(food_params)

    if @food.save
      redirect_to foods_url, notice: 'Food was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @food = Food.find(params[:id])

    if @food.destroy
      flash[:success] = 'Food was successfully deleted.'
    else
      flash[:error] = 'Error: Food could not be deleted'
    end
    redirect_to foods_url
  end

  private

  def food_params
    params.require(:food).permit(:user_id, :name, :measurement_unit, :price, :quantity)
  end
end
