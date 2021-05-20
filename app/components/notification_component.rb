# frozen_string_literal: true

class NotificationComponent < ViewComponent::Base
  def initialize(type:, data:)
    @type = type
    @data = data
    @bg_color = get_color
  end

  private

  def get_color
    case @type
    when 'alert'
      'bg-red-500'
    else
      'bg-black'
    end
  end

end
