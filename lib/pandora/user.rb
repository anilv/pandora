module Pandora
  # User class to get data for a particular user.
  # == Initiating User
  # user = Pandora::User.new("username")
  # this 'user' defined will be used in examples to invoke methods below. 
  # After the methods are invoked the results can be iterated over for each song, artist, staiton, item.
  #
  class User
    
    include Pandora::Request # Include the Request module to invoke Nokogiri.
    
    attr_accessor :user
    
    # Create a new user and make sure no whitespace, since it will be parsed as url in the request.
    def initialize(user)
      @user = user.downcase.strip
    end
    
    # == Returns the Bookmarked Songs
    # 
    #    bookmarked_songs = user.bookmarked_songs
    #
    # will return the parameters below:
    # === Parameters:
    # title:: Name of the song
    # link:: Link to the song
    # description:: Description of the song and the artist
    # date:: Date the song was bookmarked
    # track:: Song name
    # artist:: Artist name
    # album:: Album name
    # artwork:: Artwork of the album
    # station:: Station link to the song
    #  
    def bookmarked_songs
      doc = request(@user, "favorites")
      songs = []
      doc.xpath('//rss/channel/item').each do |node|
        songs << { :title       => node.xpath('title').text.strip,
                   :link        => node.xpath('link').text.strip,
                   :description => node.xpath('description').text.strip,
                   :date        => node.xpath('pubDate').text.strip,
                   :track       => node.xpath('mm:Track/dc:title').text.strip,
                   :artist      => node.xpath('mm:Artist/dc:title').text.strip,
                   :album       => node.xpath('mm:Album/dc:title').text.strip,
                   :artwork     => node.xpath('pandora:albumArtUrl').text.strip,
                   :station     => node.xpath('pandora:stationLink').text.strip }
      end
      songs
    end
    
    # == Returns the Bookmarked Artists
    # 
    #    bookmarked_artists = user.bookmarked_artists
    #
    # will return the parameters below:
    # === Parameters:
    # title:: Name of the artist
    # link:: Link to the artist
    # description:: Description of the artist
    # date:: Date the artist was bookmarked
    # station:: Station link to the station
    #
    def bookmarked_artists
      doc = request(@user, "favoriteartists")
      artists = []
      doc.xpath('//rss/channel/item').each do |node|
        artists << { :title       => node.xpath('title').text.strip,
                     :link        => node.xpath('link').text.strip,
                     :description => node.xpath('description').text.strip,
                     :date        => node.xpath('pubDate').text.strip,
                     :artist      => node.xpath('mm:Artist/dc:title').text.strip,
                     :station     => node.xpath('pandora:stationLink').text.strip }
      end
      artists
    end
    
    # == Returns the Stations created
    # 
    #    stations = user.stations
    #
    # will return the parameters below:
    # === Parameters:
    # title:: Title of the station
    # link:: Link to the station
    # description:: Description of the station
    # date:: Date the station was created
    # artwork:: Artwork of the station
    # songSeed:: Array of hashes {:song => "..", :artist => ".."} representing songs used to create the station
    # composerSeed:: Array of names of the composers used to create the station
    # artistSeed:: Array of names of the artists used to create the station
    #
    def stations
      doc = request(@user, "stations")
      stations = []
      doc.xpath('//rss/channel/item').each do |node|
        seeds = parse_seeds(node)
        
        stations << { :title          => node.xpath('title').text.strip,
                      :link           => node.xpath('link').text.strip,
                      :description    => node.xpath('description').text.strip,
                      :date           => node.xpath('pubDate').text.strip,
                      :artwork        => node.xpath('pandora:stationAlbumArtImageUrl').text.strip,
                      :songSeed       => seeds[:song],
                      :composerSeed   => seeds[:composer],
                      :artistSeed     => seeds[:artist]}
      end
      stations
    end
    
    # == Returns the Station Now Playing
    # 
    #    now_playing = user.now_playing
    #
    # will return the parameters below:
    # === Parameters:
    # title:: Title of the station
    # link:: Link to the station
    # description:: Description of the station
    # date:: Date the station was last played
    # artwork:: Artwork of the station
    # songSeed:: Array of hashes {:song => "..", :artist => ".."} representing songs used to create the station
    # composerSeed:: Array of names of the composers used to create the station
    # artistSeed:: Array of names of the artists used to create the station
    #
    def now_playing
      doc = request(@user, "nowplaying")
      station = []
      doc.xpath('//rss/channel/item').each do |node|
        seeds = parse_seeds(node)
        
        station << { :title         => node.xpath('title').text.strip,
                     :link          => node.xpath('link').text.strip,
                     :description   => node.xpath('description').text.strip,
                     :date          => node.xpath('pubDate').text.strip,
                     :artwork       => node.xpath('pandora:stationAlbumArtImageUrl').text.strip,
                     :songSeed      => seeds[:song],
                     :composerSeed  => seeds[:composer],
                     :artistSeed    => seeds[:artist]}
      end
      station
    end
    
    # == Returns the Recent Activity
    # 
    #    recent_activity = user.recent_activity
    #
    # will return the parameters below:
    # === Parameters:
    # title:: Title of the item(song or artist)
    # link:: Link to the item(song or artist)
    # description:: Description of the song and the artist
    # date:: Date the song was modified
    # track:: Song name
    # artist:: Artist name
    # album:: Album name
    # artwork:: Artwork of the item
    # station:: Station link to the item
    #
    def recent_activity
      doc = request(@user, "recentactivity")
      items = []
      doc.xpath('//rss/channel/item').each do |node|
        items << { :title       => node.xpath('title').text.strip,
                   :link        => node.xpath('link').text.strip,
                   :description => node.xpath('description').text.strip,
                   :date        => node.xpath('pubDate').text.strip,
                   :track       => node.xpath('mm:Track/dc:title').text.strip,
                   :artist      => node.xpath('mm:Artist/dc:title').text.strip,
                   :album       => node.xpath('mm:Album/dc:title').text.strip,
                   :artwork     => node.xpath('pandora:albumArtUrl').text.strip,
                   :station     => node.xpath('pandora:stationLink').text.strip}
      end
      items
    end
    
    private
      def parse_seeds(node)
        seeds = {
          :song     => [],
          :composer => [],
          :artist   => []
        }
        
        if node.is_a? Nokogiri::XML::Node
          node.xpath('pandora:seeds/pandora:songSeed').each do |s|
            
            song    = s.xpath("pandora:song").text.strip
            artist  = s.xpath("pandora:artist").text.strip
            
            seeds[:song] << {
              :song   => song,
              :artist => artist
            }
          end
          
          node.xpath('pandora:seeds/pandora:composerSeed/pandora:composer').each do |c|
            seeds[:composer] << c.text.strip
          end
          
          node.xpath('pandora:seeds/pandora:artistSeed/pandora:artist').each do |a|
            seeds[:artist] << a.text.strip
          end
        end
        
        seeds
      end
  end
end