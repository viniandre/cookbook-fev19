require 'rails_helper'

feature 'User register cuisine' do
  scenario 'successfully' do 
    visit root_path
    click_on 'Cadastrar cozinha'
    fill_in 'Nome', with: 'Brasileira'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Brasileira')
  end

  scenario 'and must fill in name' do
    visit root_path
    click_on 'Cadastrar cozinha'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar o nome do tipo de receita')
  end

  scenario 'must have unique name' do
    Cuisine.create(name: 'Brasileira')

    visit root_path
    click_on 'Cadastrar cozinha'
    fill_in 'Nome', with: 'Brasileira'
    click_on 'Enviar'
    
    expect(page).to have_content('Não é possível cadastrar cozinha existente')
  end

end