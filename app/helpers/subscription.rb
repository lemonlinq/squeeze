class Subscription
  TIERS = {
    "Free" => { link_limit: 10, price: 0 },
    "Starter" => { link_limit: 50, price: 5 },
    "Pro" => { link_limit: 100, price: 15 },
    "Enterprise" => { link_limit: Float::INFINITY, price: 50 }
  }.freeze

  def self.link_limit_for(tier)
    TIERS[tier || "Free"][:link_limit] # Default to "Free" if no tier is assigned
  end

  def self.price_for(tier)
    TIERS[tier][:price]
  end
end
