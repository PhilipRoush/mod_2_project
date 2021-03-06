class Song < ApplicationRecord
   belongs_to :artist
   belongs_to :genre
   has_many :ratings
   has_many :users, through: :ratings
    
   validates :title, presence: true
   validates :artist_id, presence: true
   validates :genre_id, presence: true
   validates :release_date, presence: true
   validates :link, presence: true
   validates_date :release_date, :on_or_before => lambda { Date.current }
   validates :title, uniqueness: {scope: :artist_id}

   #lets us create/find an artist via the new song form
   def artist_attributes=(artist)
      self.artist = Artist.find_or_create_by(name: artist[:name])
      self.artist.update(artist)
   end

   #lets us create/find a genre via the new song form 
   def genre_attributes=(genre)
      self.genre = Genre.find_or_create_by(name: genre[:name])
      self.genre.update(genre)
   end

   #returns an array of songs that have ratings
   def self.rated_songs
      Song.all.reject do |song|
         song.average_rating == nil
      end
   end

   #returns an array of 10 songs that have ratings, sorted from highest average rating to lowest
   def self.top_songs
      sorted = Song.rated_songs.sort_by do |song| 
         song.average_rating
      end.reverse
      until sorted.length <= 10 do
         sorted.pop
      end
      sorted
   end

end