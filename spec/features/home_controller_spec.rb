require 'rails_helper'

RSpec.feature HomeController, type: :feature do

  describe 'GET with locale query param' do
    it 'should be return en locale' do
      visit "/?locale=en"
      expect(page).to have_link("Login")
    end
    it 'should be return es locale' do
      visit "/?locale=es"
      expect(page).to have_link("Iniciar sesión")
    end
    it 'should be return en locale with invalid option' do
      visit "/?locale=noption"
      expect(page).to have_link("Login")
    end
  end

  describe 'GET /step/2 with authenticated user' do
    before(:each) do
      @user = FactoryBot.create(:user)
      login_as(@user, :scope => :user)
      visit '/step/2'
    end

    it 'should redirect to /step/1' do
      expect(current_path).to eql(new_step_path(1))
      expect(page).to have_content('Primero asigna el nombre a tu personaje')
      expect(page).to have_content('Ingresa el nombre de tu personaje')
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

  describe 'GET / with authenticated user' do
    let(:character_name) { Faker::Name.first_name }
    before(:each) do
      @user = FactoryBot.create(:user)
      login_as(@user, :scope => :user)
      visit '/'
    end

    it 'should have logout link' do
      expect(page).to have_content 'Cerrar sesión'
      expect(page).to_not have_content 'Atrás'
    end

    it 'should be fill and redirect to step 2' do
      fill_in 'Nombre', with: character_name
      click_button 'Siguiente'
      expect(page).to have_content "Selecciona el color de #{character_name}"
      expect(page).to have_button 'Siguiente'
    end

    it 'should be fill step 1 and step 2, after show step 3' do
      fill_in 'Nombre', with: character_name
      click_button 'Siguiente'
      find(:css, '#character_color').find(:xpath, 'option[2]').select_option
      click_button 'Siguiente'
      expect(page).to have_content "Selecciona la clase de #{character_name}"
      expect(page).to have_button 'Crear'
    end

    it 'should be fill all steps and show success page' do
      fill_in 'Nombre', with: character_name
      click_button 'Siguiente'
      find(:css, '#character_color').find(:xpath, 'option[2]').select_option
      click_button 'Siguiente'
      expect(page).to have_content "Selecciona la clase de #{character_name}"
      find(:css, '#character_kind_class').find(:xpath, 'option[2]').select_option
      expect(page).to have_button 'Crear'
      click_button 'Crear'
      expect(page).to have_content 'Mostrando personaje'
      expect(page).to have_content(character_name)
      expect(page).to have_content('Azul')
      expect(page).to have_content('Hechicero')
    end
  end
end