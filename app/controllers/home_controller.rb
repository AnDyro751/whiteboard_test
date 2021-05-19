class HomeController < ApplicationController
  before_action :set_character

  def index; end

  def switch_locale
    set_locale_in_session(params['locale'])
    respond_to do |format|
      format.js
    end
  end

  private

  def set_character
    if user_signed_in?
      @character = if current_user.character.nil?
                     Character.new(session[:new_character])
                   else
                     current_user.character
                   end
    end
  end


end