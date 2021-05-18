class Character < ApplicationRecord

  # Relationships

  belongs_to :user

  # validations

  validates :name, presence: true, length: {in: 1..30}
  validates :color, presence: true, inclusion: %w[red blue yellow green orange pink]
  validates :kind_class, presence: true, inclusion: %w[wizard sorcerer warrior knight hunter assassin priest healer]

  # @param [Numeric] step
  # @param [Object] errors
  # @return [Array] valid_errors
  def valid_errors_step(step, errors)
    valid_errors = []
    if Character.valid_step?(step)
      errors.each do |error|
        valid_errors.push(error) if error.attribute.to_s == get_errors_by_step(step)
      end
    else
      return []
    end
    return valid_errors
  end

  def self.valid_kind_class
    [
        [I18n.t("characters.wizard"), "wizard"],
        [I18n.t("characters.sorcerer"), "sorcerer"],
        [I18n.t("characters.warrior"), "warrior"],
        [I18n.t("characters.knight"), "knight"],
        [I18n.t("characters.hunter"), "hunter"],
        [I18n.t("characters.assassin"), "assassin"],
        [I18n.t("characters.priest"), "priest"],
        [I18n.t("characters.healer"), "healer"],
    ]
  end

  # @return [Array]
  def self.valid_colors
    [
        [I18n.t('colors.red'), 'red',],
        [I18n.t('colors.blue'), 'blue'],
        [I18n.t('colors.yellow'), 'yellow'],
        [I18n.t('colors.green'), 'green'],
        [I18n.t('colors.orange'), 'orange'],
        [I18n.t('colors.pink'), 'pink']
    ]
  end

  # @param [Numeric] i
  # @return [TrueClass]
  def self.last_step?(i)
    i === 3
  end

  private


  # @param [Numeric] step
  # @return [String]
  def get_errors_by_step(step)
    case step
    when 1
      return 'name'
    when 2
      return 'color'
    when 3
      return 'kind_class'
    else
      return ''
    end
  end

  # @param [Integer] step
  # @return [TrueClass]
  def self.valid_step?(step)
    step.positive? && step <= 3
  end

end
