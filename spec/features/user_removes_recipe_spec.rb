require 'rails_helper'

feature 'User removes recipe' do 
  scenario 'succesfully' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    
    Recipe.create(title: 'Bolo de banana', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, banana',
                  cook_method: 'Cozinhe a banana, corte em pedaços pequenos, misture com o restante dos ingredientes')


    visit root_path
    click_on 'Bolo de cenoura'
    click_on 'Excluir'
    expect(page).to have_css('h1', text: 'Bolo de banana')
    expect(page).not_to have_css('h1', text: 'Bolo de cenoura')
    expect(Recipe.count).to eq 1

  end
end
