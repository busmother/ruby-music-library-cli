require "pry"

class Genre
    extend Concerns::Findable
    attr_accessor :name
    @@all = []

    def initialize(name)
        @name = name
        @songs = []
    end

    def name=(name)
        @name = name
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all = []
    end

    def save
        @@all << self
    end

    def self.create(genre)
        new_genre = Genre.new(genre)
        new_genre.save
        new_genre
    end

    def songs
        @songs
    end

    def self.songs
        @songs
    end

    def add_song(song)
        if song.genre == nil
            song.genre = self
        end
        if !songs.include? song 
            songs << song
        end
    end

    def artists 
        full_list = @songs.map{|song| song.artist}
        full_list.uniq
    end

end