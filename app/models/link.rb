class Link < ApplicationRecord
  belongs_to :user, optional: true
  validates :original_url, presence: true, format: URI::regexp(%w[http https])
  validates :short_url, uniqueness: true
  validates :session_id, presence: true, unless: -> { user.present? }

  before_validation :add_protocol_if_missing
  before_create :generate_short_url

  private

  # Automatically add protocol if missing
  def add_protocol_if_missing
    unless original_url[%r{\Ahttp[s]?://}]
      self.original_url = "https://#{original_url}"
    end
  end

  # Generate a unique short URL
  def generate_short_url
      self.short_url = SecureRandom.alphanumeric(6)
  end
end
