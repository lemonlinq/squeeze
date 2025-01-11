class AddSubscriptionTierToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :subscription_tier, :string, default: nil
  end
end
