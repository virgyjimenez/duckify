class ArtistsController < ApplicationController
  expose(:artist)
  expose(:artists)
  expose(:notes, ancestor: :user)
  expose(:artist_form){ ArtistForm.new(artist_params, artist: artist) }
  expose(:search_form){ SearchForm.new(search_params) }

  def index
    self.artists = SearchService.new(search_form).search!
  end

  # POST /users
  # POST /users.json
  def create
    respond_to do |format|
      if artist_form.save
        format.html { redirect_to artist_form.artist, notice: 'Artist was successfully created.' }
        format.json { render :show, status: :created, location: @artist }
      else
        format.html { render :new }
        format.json { render json: artist_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if artist_form.save
        format.html { redirect_to artist_path(artist_form.artist), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: artist }
      else
        format.html { render :edit }
        format.json { render json: artist_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    artist.destroy
    respond_to do |format|
      format.html { redirect_to artists_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def artist_params
    return {} unless params[:artist].present?
    params.require(:artist).permit(:name)
  end

  def search_params
    return {} unless params[:search].present?
    params.require(:search)
  end
end
