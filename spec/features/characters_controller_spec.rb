require 'rails_helper'

RSpec.feature HomeController, type: :feature do
  describe 'GET /' do
    it 'should render login text' do
      visit '/'
      expect(page).to have_content "Inicia sesión para crear tu personaje"
    end
  end

end