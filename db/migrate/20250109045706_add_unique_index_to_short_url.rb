class AddUniqueIndexToShortUrl < ActiveRecord::Migration[7.1]
  def change
    add_index :links, :short_url, unique: true
  end
end
