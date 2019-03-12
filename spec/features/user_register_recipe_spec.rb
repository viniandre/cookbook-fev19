require 'rails_helper'

feature 'User register recipe' do
  scenario 'successfully' do
    #cria os dados necessários, nesse caso não vamos criar dados no banco
    RecipeType.create(name: 'Sobremesa')
    RecipeType.create(name: 'Entrada')
    Cuisine.create(name: 'Arabe')
    User.create!(email: 'vini@aol.com.br', password: '123456')

    mailer_spy = class_spy(RecipesMailer)
    stub_const('RecipesMailer', mailer_spy)

    # simula a ação do usuário
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'vini@aol.com.br'
    fill_in 'Senha', with: '123456'
    click_on 'Enviar'
    click_on 'Enviar uma receita'

    fill_in 'Título', with: 'Tabule'
    select 'Entrada', from: 'Tipo da Receita'
    select 'Arabe', from: 'Cozinha'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão a gosto.'
    attach_file 'Foto', Rails.root.join('spec', 'support', 'Tabule.jpg')
    click_on 'Enviar'

    # expectativas
    recipe = Recipe.last
    expect(RecipesMailer).to have_received(:notify_new_recipe).with(recipe.id)
    expect(page).to have_css('h1', text: 'Tabule')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Entrada')
    expect(page).to have_css('p', text: 'Arabe')
    expect(page).to have_css('p', text: 'Fácil')
    expect(page).to have_css('p', text: "45 minutos")
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text:  'Misturar tudo e servir. Adicione limão a gosto.')
    expect(page).to have_css('img[src*="Tabule.jpg"]')
    expect(page).to have_css('p', text: "Receita cadastrada por: vini@aol.com.br")
  end

  scenario 'and must fill in all fields' do
    User.create!(email: 'vini@aol.com.br', password: '123456')

    # simula a ação do usuário
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'vini@aol.com.br'
    fill_in 'Senha', with: '123456'
    click_on 'Enviar'
    click_on 'Enviar uma receita'

    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'


    expect(page).to have_content('Não foi possível salvar a receita')
  end

  scenario 'and must be logged in' do

    visit root_path
    click_on 'Enviar uma receita'

    expect(current_path).to eq new_user_session_path

  end

  scenario 'from route path' do
    visit new_recipe_path
    
    expect(current_path).to eq new_user_session_path
  end
end
