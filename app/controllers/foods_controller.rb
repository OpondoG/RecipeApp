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
    @food = Food.find_by(id: params[:id])

    respond_to do |format|
      if @food.destroy
        format.html { redirect_to foods_url, notice: 'Food was successfully destroyed.' }
      else
        format.html { redirect_to foods_url, error: 'Failed to Delete the Food.' }
      end
    end
  end
  
    

  def show
    @food = Food.find(params[:id])
  end

  private

  def food_params
    params.require(:food).permit(:user_id, :name, :measurement_unit, :price, :quantity)
  end
end
