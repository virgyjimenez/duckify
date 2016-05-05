class ArtistForm
  include ActiveModel::Model
  include Virtus.model
  include Rails.application.routes.url_helpers

  attribute :name, String

  validates :name, presence: true

  attr_accessor :artist

  def initialize(attrs = {}, artist: nil)
    self.artist = artist || Artist.new
    self.name = artist.name
    super(attrs)
  end

  def save
    if valid?
      persist!
    else
      false
    end
  end

  def method
    return :put if artist.persisted?
    :post
  end

  def action
    return artist_path(artist) if artist.persisted?
    artists_path
  end

  def persist!
    self.artist.name = name
    self.artist.save!
  end
end
