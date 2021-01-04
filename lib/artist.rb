require "pry"
class Artist
    attr_accessor :name, :songs
    extend Concerns::Findable
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

    def self.save
        @@all << self
    end

    def self.create(artist)
        new_artist = Artist.new(artist)
        new_artist.save
        new_artist
    end

    def add_song(song)
        if song.artist == nil 
            song.artist = self
        end
        if !songs.include? song 
        songs << song
        end
    end

    def genres
        full_list = @songs.map{|song| song.genre}
        full_list.uniq
    end

    def songs
        @songs
    end

end
