class ApplicationController < ActionController::Base
  before_action :set_locale

  # @return [I18n] language
  def set_locale
    if params[:locale]
      set_locale_language
    else
      if session[:locale]
        set_locale_session
      else
        set_header_language
      end
    end
  end

  # @return [I18n] language
  def set_locale_session
    set_locale_in_session(session[:locale])
  end

  def valid_language?(lang)
    I18n.available_locales.map(&:to_s).include?(lang)
  end

  # @return [I18n] language
  def set_header_language
    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    locale = extract_locale_from_accept_language_header
    logger.debug "* Locale set to '#{locale}'"
    set_locale_in_session(locale)
  end

  # @return [I18n] language
  def set_locale_language
    locale = params[:locale] || I18n.default_locale
    logger.debug "#{locale}"
    set_locale_in_session(locale)
  end

  # @param [String] locale
  # @return [I18n] language
  def set_locale_in_session(locale)
    valid_locale = valid_language?(locale)
    session[:locale] = valid_locale ? locale : I18n.default_locale
    I18n.locale = session[:locale]
  end


  private

  # @return [String] Language header
  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end

end
