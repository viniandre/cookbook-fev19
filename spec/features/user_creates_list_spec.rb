require 'rails_helper'

feature 'User adds recipe to list' do
  scenario 'successfully' do
    user = User.create!(email: 'vini@aol.com.br', password: '123456')

    recipe_type = RecipeType.create(name: 'Sobremesa')
    
    cuisine = Cuisine.create(name: 'Brasileira')
    
    Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user)

    List.create(name: 'Churrasco', user: user)

    login_as user, scope: :user
    visit root_path
    click_on 'Bolo de cenoura'
    select 'Churrasco', from: 'Listas'
    click_on 'Adicionar'

    expect(current_path).to eq list_path(1)
    expect(page).to have_content('Receita adicionada com sucesso')
    expect(page).to have_css('h1', text: 'Bolo de cenoura')

  end

end
