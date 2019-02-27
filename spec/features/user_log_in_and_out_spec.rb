require 'rails_helper'

feature 'User logs in' do
  scenario 'successfully' do 
    User.create!(email: 'vini@aol.com.br', password: '123456')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'vini@aol.com.br'
    fill_in 'Senha', with: '123456'
    click_on 'Enviar'

    expect(current_path).to eq root_path
    expect(page).to have_link('Sair')
    expect(page).to have_content('Bem vindo, vini@aol.com.br.')
  end

  scenario 'and logs out' do
    User.create!(email: 'vini@aol.com.br', password: '123456')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'vini@aol.com.br'
    fill_in 'Senha', with: '123456'
    click_on 'Enviar'
    click_on 'Sair'

    expect(current_path).to eq root_path
    expect(page).to have_link('Entrar')
    expect(page).not_to have_content('Bem vindo, vini@aol.com.br.')
  end

end
