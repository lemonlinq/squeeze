class RemoveUniqueIndexFromOriginalUrl < ActiveRecord::Migration[7.1]
  def change
    remove_index :links, :original_url if index_exists?(:links, :original_url)
  end
end
