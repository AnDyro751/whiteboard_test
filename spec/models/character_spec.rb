require 'rails_helper'

RSpec.describe Character, :type => :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(1).is_at_most(30) }
    it { should validate_inclusion_of(:color).in_array(%w[red blue yellow green orange pink]) }
    it { should validate_inclusion_of(:kind_class).in_array(%w[wizard sorcerer warrior knight hunter assassin priest healer]) }
    it { should validate_presence_of(:color) }
    it { should validate_presence_of(:kind_class) }
  end

  context 'invalid' do
    let(:user) { FactoryBot.create(:user) }
    it 'should be return invalid because name length is < 1' do
      character = FactoryBot.build(:character, {name: '', user: user})
      expect(character.valid?).to eq(false)
    end

    it 'should be return invalid because name length is > 100' do
      character = FactoryBot.build(:character, {name: SecureRandom.hex(120), user: user})
      expect(character.valid?).to eq(false)
    end

    it 'should be return invalid because color option is not included in the list' do
      character = FactoryBot.build(:character, {color: "color_no", user: user})
      expect(character.valid?).to eq(false)
    end

    it 'should be return invalid because kind_class option is not included in the list' do
      character = FactoryBot.build(:character, {kind_class: "class_no", user: user})
      expect(character.valid?).to eq(false)
    end
  end
end