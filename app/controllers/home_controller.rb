class HomeController < ApplicationController
  before_action :set_character

  def index; end

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