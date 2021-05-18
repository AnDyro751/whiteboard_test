class CharactersController < ApplicationController

  before_action :authenticate_user!
  before_action :set_character_step, only: [:new]

  def new
    @character = Character.new(session[:new_character])
  end

  # GET /step_:step
  def next_step
    @character = Character.new(session[:new_character] ? session[:new_character].merge(character_params) : character_params)
    @character.valid?
    @errors = @character.valid_errors_step(params['character']['step'].to_i, @character.errors)
    @next_url = new_character_path(params['character']['step'].to_i + 1)
    session[:new_character] = @character.attributes
    respond_to do |format|
      format.js
    end
  end

  # POST /create
  def create
    @character = Character.new(session[:new_character].merge(character_params))
    @character.user = current_user
    respond_to do |format|
      if @character.save
        session[:new_character] = nil
        format.html { redirect_to root_path, notice: 'Character was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private


  def set_character_step
    if Character.valid_step?(params['step'].to_i)
      if params['step'].to_i > 1
        redirect_to new_character_path(1), alert: I18n.t('characters.first_add_name') if session[:new_character].nil?
      end
      @step = params['step'].to_s
    else
      redirect_to new_character_path(1), alert: I18n.t('characters.invalid_step')
    end
  end

  # Only allow a list of trusted parameters through.
  def character_params
    params.require(:character).permit(:name, :color, :kind_class)
  end
end
