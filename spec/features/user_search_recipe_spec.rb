require 'rails_helper'

feature 'User search recipe' do
  scenario 'successfully' do
    #cria os dados
    user = User.create!(email: 'vini@aol.com.br', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user)
    
    Recipe.create(title: 'Bolo de banana', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, banana',
                  cook_method: 'Cozinhe a banana, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user)

    #ação do usuario
    visit root_path
    fill_in 'Busca', with: 'Bolo de cenoura'
    click_on 'Pesquisar'

    #expectativas
    expect(page).to have_css('h1', text: 'Bolo de cenoura')
    expect(page).to have_css('li', text: 'Sobremesa')
    expect(page).to have_css('li', text: 'Brasileira')
    expect(page).to have_css('li', text: 'Médio')
    expect(page).to have_css('li', text: '50 minutos')

    expect(page).not_to have_css('h1', text: 'Bolo de banana')
  end

  scenario 'and no matches found' do
    user = User.create!(email: 'vini@aol.com.br', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user)
    
    Recipe.create(title: 'Bolo de banana', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, banana',
                  cook_method: 'Cozinhe a banana, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user)

    #ação do usuario
    visit root_path
    fill_in 'Busca', with: 'Pizza'
    click_on 'Pesquisar'

    expect(page).to have_content('Nenhuma receita encontrada')
    expect(page).not_to have_css('h1', text: 'Bolo de cenoura')
    expect(page).not_to have_css('h1', text: 'Bolo de banana')
  end

  scenario 'with parcial search_term' do
    #cria os dados
    user = User.create!(email: 'vini@aol.com.br', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user)
    
    Recipe.create(title: 'Bolo de banana', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, banana',
                  cook_method: 'Cozinhe a banana, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user)
    
                  Recipe.create(title: 'Pizza', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user)

    visit root_path
    fill_in 'Busca', with: 'Bolo'
    click_on 'Pesquisar'

    #expectativas
    expect(page).to have_css('h1', text: 'Bolo de cenoura')
    expect(page).to have_css('h1', text: 'Bolo de banana')
    expect(page).not_to have_css('h1', text: 'Pizza')
  end
end