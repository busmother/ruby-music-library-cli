require "pry"
class MusicLibraryController
    attr_accessor :path
    def initialize(path = "./db/mp3s")
        @path = path
        new_one = MusicImporter.new(path)
        new_one.import
    end

    def call_options
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
    end

    def sorted_list(list)
         sorted_list = list.sort_by {|song| song.name}
    end

    def list_songs
        songs = Song.all
        sorted_songs = sorted_list(songs)
        sorted_songs.each_with_index {|song, i| puts "#{i+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
    end

    def list_artists
        artists = Artist.all
        sorted_artists = sorted_list(artists)
        sorted_artists.each_with_index {|artist, i| puts "#{i+1}. #{artist.name}"}
    end

    def list_genres
        genres = Genre.all
        sorted_genres = sorted_list(genres)
        sorted_genres.each_with_index {|genre, i| puts "#{i+1}. #{genre.name}"}
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        artist_name = gets.chomp
        artist = Artist.find_by_name(artist_name)
        if artist != nil
        songs = artist.songs
        sorted_songs = sorted_list(songs)
        sorted_songs.each_with_index {|song, i| puts "#{i+1}. #{song.name} - #{song.genre.name}"}
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        genre_name = gets.chomp
        genre = Genre.find_by_name(genre_name)
        if genre != nil
            songs = genre.songs
            sorted_songs = sorted_list(songs)
            sorted_songs.each_with_index {|song, i| puts "#{i+1}. #{song.artist.name} - #{song.name}"}
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        song_choice = gets.chomp.to_i - 1
        songs = Song.all
        range = songs.length
        #binding.pry
        if song_choice.between?(0,range) 
            #interpret the song_choice as a song object
            sorted_songs = sorted_list(songs)
            song = sorted_songs[song_choice]
            if song != nil
                puts "Playing #{song.name} by #{song.artist.name}"
            end
        end
    end

    def exit

    end

    def call
        call_options
        response = gets.chomp
        until response == "exit"
            if response == 'list songs'
                list_songs
            elsif response == 'list artists'
                list_artists
            elsif response == 'list genres'
                list_genres
            elsif response == 'list artist'
                list_songs_by_artist
            elsif response == 'list genre'
                list_songs_by_genre
            elsif response == 'play song'
                play_song
            else exit
            end
            call_options
            response = gets.chomp
        end
    end

end