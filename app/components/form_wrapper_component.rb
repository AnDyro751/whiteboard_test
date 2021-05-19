# frozen_string_literal: true

class FormWrapperComponent < ViewComponent::Base
  # @param [String] title
  def initialize(title:)
    @title = title
  end
end
