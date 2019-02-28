require 'rails_helper'

feature 'User visits his recipes page' do
  scenario 'successfully' do
    user1 = User.create!(email: 'vini@aol.com.br', password: '123456')
    user2 = User.create!(email: 'andre@aol.com.br', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe1 = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user1)
    recipe2 = Recipe.create(title: 'Bolo de banana', difficulty: 'Médio',
                            recipe_type: recipe_type, cuisine: cuisine,
                            cook_time: 50, ingredients: 'Farinha, açucar, banana',
                            cook_method: 'Cozinhe a banana, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user2)
    
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'vini@aol.com.br'
    fill_in 'Senha', with: '123456'
    click_on 'Enviar'
    click_on 'Minhas receitas'
    
    expect(page).to have_css('h1', text: recipe1.title)
    expect(page).to have_css('li', text: recipe1.recipe_type.name)
    expect(page).to have_css('li', text: recipe1.cuisine.name)
    expect(page).to have_css('li', text: recipe1.difficulty)
    expect(page).to have_css('li', text: "#{recipe1.cook_time} minutos")
    expect(page).not_to have_css('h1', text: recipe2.title)
  end
end