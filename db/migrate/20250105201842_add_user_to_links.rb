class AddUserToLinks < ActiveRecord::Migration[7.1]
  def change
    add_reference :links, :user, null: false, foreign_key: true, null: true
  end
end
