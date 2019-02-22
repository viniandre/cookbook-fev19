class CuisinesController < ApplicationController

  def new
    @cuisine = Cuisine.new
  end
  
  def create 
    @cuisine = Cuisine.new(params.require(:cuisine).permit(:name))
    if @cuisine.save
      redirect_to @cuisine
    elsif @cuisine.name.empty?
      flash[:alert] = 'Você deve informar o nome do tipo de receita'
      render :new
    else
      flash[:alert] = 'Não é possível cadastrar cozinha existente'
      render :new 
    end
  end

  def show
    @cuisine = Cuisine.find(params[:id])
  end

end