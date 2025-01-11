class LinksController < ApplicationController

    def index
      @link = Link.new
      @links = current_user ? current_user.links.order(created_at: :desc) : Link.where(session_id: session.id.to_s).order(created_at: :desc)


  end

  def create
    if user_signed_in?
      # Enforce link limits based on the user's subscription tier
      limit = Subscription.link_limit_for(current_user.subscription_tier)
      if current_user.links.count >= limit
        render json: { error: "You have reached your link limit for the #{current_user.subscription_tier || 'Free'} plan." }, status: :forbidden
        return
      end
    else
      # Enforce link limits for logged-out users
      limit = Subscription.link_limit_for("Free") # Max 3 links for logged-out users
      current_count = Link.where(session_id: session.id.to_s).count
      if Link.where(session_id: session.id.to_s).count >= 3

        redirect_to new_user_registration_path, notice: "You have hit your limit as a free user. Please sign up to create more links!", status: :see_other

        return

      end
    end


    @link = Link.new(link_params)
    @link.user = current_user if user_signed_in?
    @link.session_id = session.id.to_s unless user_signed_in?

    if @link.save
      render json: { original_url: @link.original_url, short_url: short_url(@link.short_url) }, status: :created
    else
      render json: { errors: @link.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def redirect
    link = Link.find_by(short_url: params[:short_url])
    if link
      redirect_to link.original_url, allow_other_host: true
    else
      render plain: "URL not found", status: :not_found
    end
  end

  private

  def link_params
    params.require(:link).permit(:original_url)
  end

  def short_url(code)
    "#{request.base_url}/#{code}"
  end
end
