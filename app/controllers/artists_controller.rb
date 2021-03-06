class ArtistsController < ApplicationController

    def index
      @artists = Artist.all
    end

    def show
      @artist = find_by_id
    end

    def top10
      render :top10
    end

    private
    def find_by_id
      Artist.find(params[:id])
    end
  
  end