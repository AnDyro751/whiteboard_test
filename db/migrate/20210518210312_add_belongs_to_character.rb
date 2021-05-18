class AddBelongsToCharacter < ActiveRecord::Migration[6.1]
  def change
    add_reference :characters, :user, null: true, foreign_key: true
  end
end
