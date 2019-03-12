require 'rails_helper'

RSpec.describe RecipesMailer do
  describe '.notify_new_recipe' do
    it 'should send email to admin' do
      user = User.create!(email: 'vini@aol.com.br', password: '123456')
      recipe_type = RecipeType.create(name: 'Sobremesa')
      cuisine = Cuisine.create(name: 'Brasileira')
      recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                    recipe_type: recipe_type, cuisine: cuisine,
                    cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user)

      mail = RecipesMailer.notify_new_recipe(recipe.id)

      expect(mail.to).to eq(['admin@cookbook.com.br'])
    end
  
    it 'should have correct subjet' do
      user = User.create!(email: 'vini@aol.com.br', password: '123456')
      recipe_type = RecipeType.create(name: 'Sobremesa')
      cuisine = Cuisine.create(name: 'Brasileira')
      recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                    recipe_type: recipe_type, cuisine: cuisine,
                    cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user)

      mail = RecipesMailer.notify_new_recipe(recipe.id)

      expect(mail.subject).to include('Parabens vc é o ganhador!') 
    end
  
    it 'should include recipe' do
      user = User.create!(email: 'vini@aol.com.br', password: '123456')
      recipe_type = RecipeType.create(name: 'Sobremesa')
      cuisine = Cuisine.create(name: 'Brasileira')
      recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                    recipe_type: recipe_type, cuisine: cuisine,
                    cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user)

      mail = RecipesMailer.notify_new_recipe(recipe.id)

      expect(mail.body).to include(recipe.title)
      
    end
    
  end

end