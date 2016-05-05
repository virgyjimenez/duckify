class SearchService
  attr_accessor :form, :search

  def initialize(search_form)
    self.form = search_form
    self.search = Artist.all
  end

  def search!
    filter_name if form.name.present?
    search
  end

  private

  def filter_name
    self.search = search.where('artists.name like ?', "%#{ form.name.presence }%")
  end
end
