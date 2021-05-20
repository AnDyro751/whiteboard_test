require 'rails_helper'

RSpec.feature HomeController, type: :feature do

  describe 'logout' do
    before(:each) do
      @user = FactoryBot.create(:user)
      login_as(@user, :scope => :user)
      visit "/"
    end
    it 'should render login button' do
      click_link 'Cerrar sesión'
      expect(page).to have_content('Sesión finalizada.')
    end
  end

  describe 'Change locale with dropdown menu' do

    it 'should be change es locale to en' do
      visit '/'
      find(:css, '#locale_select').find(:xpath, 'option[2]').select_option
      expect(page).to have_link('Login')
    end
  end

  describe 'GET with locale query param' do
    it 'should be return en locale' do
      visit '/?locale=en'
      expect(page).to have_link('Login')
    end
    it 'should be return es locale' do
      visit '/?locale=es'
      expect(page).to have_link('Iniciar sesión')
    end
    it 'should be return en locale with invalid option' do
      visit '/?locale=noption'
      expect(page).to have_link('Login')
    end
  end




  describe 'GET / with unauthenticated user' do
    before(:each) do
      visit '/'
    end
    it 'should render login text' do
      expect(page).to have_content 'Inicia sesión para crear tu personaje'
    end
    it 'should click in sign in link and go to sign in page' do
      click_link 'Iniciar sesión'
      expect(page).to have_content 'Iniciar sesión'
    end

    it 'should click in sign in link, fill sign in form and fail login' do
      click_link 'Iniciar sesión'
      fill_in 'Correo Electrónico', with: 'angelmendezz@gmail.com'
      fill_in 'Contraseña', with: '123456'
      click_button 'Iniciar sesión'
      expect(page).to have_content('Email o contraseña inválidos.')
    end
    it 'should click and sign in link, fill sign in form and success login' do
      @user = FactoryBot.create(:user)
      click_link 'Iniciar sesión'
      fill_in 'Correo Electrónico', with: @user.email
      fill_in 'Contraseña', with: '123456'
      click_button 'Iniciar sesión'
      expect(page).to have_content('Ingresa el nombre de tu personaje')
    end
  end

end