class Link < ApplicationRecord
  validates :original_url, presence: true, format: URI::regexp(%w[http https])
  validates :short_url, uniqueness: true

  before_create :generate_short_url

  private

  def generate_short_url
    self.short_url = SecureRandom.alphanumeric(6)
  end
end
