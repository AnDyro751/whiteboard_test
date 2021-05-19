class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Relationships

  has_one :character, dependent: :destroy
end
