class ApplicationController < ActionController::Base
  around_action :switch_locale

  # @param [Proc] action
  # @return [I18n] language
  def switch_locale(&action)
    if params[:locale]
      set_locale_language(&action)
    else
      if session[:locale]
        set_locale_session(&action)
      else
        set_header_language(&action)
      end
    end
  end

  # @param [Proc] action
  # @return [I18n] language
  def set_locale_session(&action)
    set_locale(session[:locale], &action)
  end

  def valid_language?(lang)
    I18n.available_locales.map(&:to_s).include?(lang)
  end

  # @return [I18n] language
  # @param [Proc] action
  def set_header_language(&action)
    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    locale = extract_locale_from_accept_language_header
    logger.debug "* Locale set to '#{locale}'"
    set_locale(locale, &action)
  end

  # @return [I18n] language
  # @param [Proc] action
  def set_locale_language(&action)
    locale = params[:locale] || I18n.default_locale
    logger.debug "#{locale}"
    set_locale(locale, &action)
  end

  # @param [String] locale
  # @return [I18n] language
  def set_locale(locale, &action)
    valid_locale = valid_language?(locale)
    session[:locale] = valid_locale ? locale : I18n.default_locale
    I18n.with_locale(session[:locale], &action)
  end


  private

  # @return [String] Language header
  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end

end
