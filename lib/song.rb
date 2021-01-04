require "pry"
class Song
    attr_accessor :name, :artist, :genre
    @@all = []

    def initialize(name, artist=nil, genre=nil)
        @name = name
        if artist != nil
        self.artist = artist
        end
        if genre != nil
        self.genre = genre
        end
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

    def self.create(song)
        new_song = Song.new(song)
        new_song.save
        new_song
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def self.artist
        @artist
    end

    def genre
        @genre
    end

    def genre=(genre)
        @genre = genre
        if @genre.songs.include? self
            self
        else
            @genre.songs << self    
        end
    end

    def self.genre
        @genre
    end

    def self.find_by_name(name)
        self.all.find{|song| song.name == name}
    end

    def self.find_or_create_by_name(name)
        self.find_by_name(name) == nil ? self.create(name) : self.find_by_name(name)
    end

    def self.new_from_filename(filename)
        artist_name = filename.split(" - ")[0]
        song_name = filename.split(" - ")[1]
        genre_name = filename.split(" - ")[2].split(".")[0]
        song = Song.find_or_create_by_name(song_name)
        artist = Artist.find_or_create_by_name(artist_name)
        genre = Genre.find_or_create_by_name(genre_name)
        song.artist = artist
        song.genre = genre
        song
    end

    def self.create_from_filename(filename)
        self.new_from_filename(filename)
    end
end