FactoryBot.define do
  factory :character do
    name { Faker::Name.first_name }
    color { 'red' }
    kind_class { 'knight' }
  end
end