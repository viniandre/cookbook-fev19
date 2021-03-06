class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, 
                                            :favorite, :unfavorite]
  
  def index
    @recipes = Recipe.all
    @last_recipes = Recipe.last(6)
  end

  def show
    @recipe = Recipe.find(params[:id])
    @user_lists = current_user.lists
  end

  def new
    @recipe = Recipe.new
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    @recipe.favorite = false
    if @recipe.save
      #RecipeMailer.with(recipe_id: @recipe.id).notify_new_recipe
      RecipesMailer.notify_new_recipe(@recipe.id)
      redirect_to @recipe
    else
      flash[:alert] = 'Não foi possível salvar a receita'
      @recipe_types = RecipeType.all
      @cuisines = Cuisine.all
      render 'new'
    end

  end

  def edit
    @recipe = Recipe.find(params[:id])
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end

  def update
    @recipe = Recipe.find(params[:id])
    
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else 
      flash[:alert] = 'Não foi possível salvar a receita'
      @recipe_types = RecipeType.all
      @cuisines = Cuisine.all
      render 'edit'
    end
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    redirect_to root_path
  end

  def search
    @recipes = Recipe.where('title like ?', "%#{params[:search_term]}%")
    if @recipes.empty?
      flash[:alert] = 'Nenhuma receita encontrada'
    end
  end

  def favorite
    @recipe = Recipe.find(params[:id])
    @recipe.update(favorite: true)
    redirect_to root_path
  end

  def unfavorite
    @recipe = Recipe.find(params[:id])
    @recipe.update(favorite: false)
    redirect_to root_path
  end

  def my_recipes
    @recipes = current_user.recipes
  end

  def add_list
    @list = List.find(params[:list_id])
    recipe = Recipe.find(params[:id])
    ListRecipe.create!(list: @list, recipe: recipe)
    flash[:notice] = 'Receita adicionada com sucesso'
    redirect_to @list
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id, :difficulty,
                                   :cook_time, :ingredients, :cook_method, :photo, :favorite)
  end
end
