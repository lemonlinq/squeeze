class LinksController < ApplicationController

    def index
      @link = Link.new
      @links = Link.order(created_at: :desc) # Fetch all links, or [] if none exist

  end

  def create


    @link = Link.new(link_params)
    @link.user = current_user if user_signed_in?

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
