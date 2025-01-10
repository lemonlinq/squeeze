class AddSessionIdToLinks < ActiveRecord::Migration[7.1]
  def change
    add_column :links, :session_id, :string
    add_index :links, :session_id
  end
end
