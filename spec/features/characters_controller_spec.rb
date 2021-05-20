require 'rails_helper'
RSpec.feature CharactersController, type: :feature do
  describe 'empty values in form' do
    let(:character_name) { Faker::Name.first_name }
    before(:each) do
      @user = FactoryBot.create(:user)
      login_as(@user, :scope => :user)
    end
    it 'should be return error when name is empty' do
      visit '/'
      expect(page).to have_content('Ingresa el nombre de tu personaje')
      click_button 'Siguiente'
      expect(page).to have_content('name no puede estar vacío')
    end

    it 'should be return error when color has invalid value' do
      visit '/'
      fill_in 'Nombre', with: character_name
      click_button 'Siguiente'
      expect(page).to have_content("Selecciona el color de #{character_name}")
      page.execute_script("document.querySelector('#character_color').options[1].value = 'invalid'")
      find(:css, '#character_color').find(:xpath, 'option[2]').select_option
      click_button 'Siguiente'
      expect(page).to have_content('color no está incluido en la lista')
    end

    it 'should be return error when kind_class has invalid value' do
      visit '/'
      fill_in 'Nombre', with: character_name
      click_button 'Siguiente'
      expect(page).to have_content("Selecciona el color de #{character_name}")
      find(:css, '#character_color').find(:xpath, 'option[2]').select_option
      click_button 'Siguiente'
      expect(page).to have_content("Selecciona la clase de #{character_name}")
      page.execute_script("document.querySelector('#character_kind_class').options[1].value = 'invalid'")
      find(:css, '#character_kind_class').find(:xpath, 'option[2]').select_option
      click_button 'Crear'
      expect(page).to have_content('kind_class no está incluido en la lista')
    end

  end
  describe 'GET /step/2345' do
    it 'should be redirect to step 1' do
      @user = FactoryBot.create(:user)
      login_as(@user, :scope => :user)
      visit '/step/123456'
      expect(current_path).to eql(new_step_path(1))
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
