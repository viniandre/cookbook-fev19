require 'rails_helper'

feature 'User should not create a recipe' do
  scenario 'with cook time zero' do

    # simula a ação do usuário
    visit root_path
    click_on "Enviar uma receita"

    fill_in 'Título', with: 'Tapioca com ovos'
    fill_in 'Tipo da Receita', with: 'Entrada'
    fill_in 'Cozinha', with: 'Brasileira'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '0'
    fill_in 'Ingredientes', with: 'Tapioca, ovos'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir.'
    click_on 'Enviar'

    # expectativas 
    expect(page).to have_content('O tempo de preparo deve ser maior que zero')

  end
  scenario 'with negative cook time' do

    # simula a ação do usuário
    visit root_path
    click_on "Enviar uma receita"

    fill_in 'Título', with: 'Tapioca com ovos'
    fill_in 'Tipo da Receita', with: 'Entrada'
    fill_in 'Cozinha', with: 'Brasileira'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '-1'
    fill_in 'Ingredientes', with: 'Tapioca, ovos'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir.'
    click_on 'Enviar'

    # expectativas 
    expect(page).to have_content('O tempo de preparo deve ser maior que zero')


  end
end