class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @tiers = Subscription::TIERS.except("Free") # Exclude free tier from selection
  end

  def create
    tier = params[:tier]
    price = Subscription.price_for(tier)

    # Implement payment logic with Stripe (or another provider)
    # Example: Stripe Checkout session creation

    current_user.update(subscription_tier: tier)
    redirect_to root_path, notice: "You have successfully subscribed to the #{tier} plan!"
  end
end
