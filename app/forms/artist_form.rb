class ArtistForm
  include ActiveModel::Model
  include Virtus.model

  attribute :name, String

  validates :name, presence: true

  attr_accessor :artist

  def save
    self.artist = Artist.new
    if valid?
      self.artist.name = name
      self.artist.save
    else
      false
    end
  end
end
