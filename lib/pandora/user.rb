module Pandora
  class User
    include Pandora::Request
    
    attr_accessor :user
    
    def initialize(user)
      @user = user.strip
    end
    
    def bookmarked_songs
      doc = request(@user, "favorites")
      songs = []
      doc.xpath('//rss/channel/item').each do |node|
        songs << { :title       => node.xpath('title').text,
                   :link        => node.xpath('link').text,
                   :description => node.xpath('description').text,
                   :date        => node.xpath('pubDate').text,
                   :track       => node.xpath('mm:Track/dc:title').text,
                   :artist      => node.xpath('mm:Artist/dc:title').text,
                   :album       => node.xpath('mm:Album/dc:title').text,
                   :artwork     => node.xpath('pandora:albumArtUrl').text,
                   :station     => node.xpath('pandora:stationLink').text }
      end
      songs
    end
    
    def bookmarked_artists
      doc = request(@user, "favoriteartists")
      artists = []
      doc.xpath('//rss/channel/item').each do |node|
        artists << { :title       => node.xpath('title').text,
                     :link        => node.xpath('link').text,
                     :description => node.xpath('description').text,
                     :date        => node.xpath('pubDate').text,
                     :artist      => node.xpath('mm:Artist/dc:title').text,
                     :artwork     => node.xpath('pandora:artistPhotoUrl').text,
                     :station     => node.xpath('pandora:stationLink').text }
      end
      artists
    end
    
    def stations
      doc = request(@user, "stations")
      stations = []
      doc.xpath('//rss/channel/item').each do |node|
        stations << { :title       => node.xpath('title').text,
                      :link        => node.xpath('link').text,
                      :description => node.xpath('description').text,
                      :date        => node.xpath('pubDate').text,
                      :artwork     => node.xpath('pandora:stationAlbumArtImageUrl').text,
                      :songSeed_song   => node.xpath('pandora:seeds/pandora:songSeed/pandora:song').text,
                      :songSeed_artist => node.xpath('pandora:seeds/pandora:songSeed/pandora:artist').text,
                      :composerSeed    => node.xpath('pandora:seeds/pandora:composerSeed/pandora:composer').text,
                      :artistSeed      => node.xpath('pandora:seeds/pandora:artistSeed/pandora:artist') }
      end
      stations
    end
    
    def now_playing
      doc = request(@user, "nowplaying")
      station = []
      doc.xpath('//rss/channel/item').each do |node|
        station << { :title       => node.xpath('title').text,
                     :link        => node.xpath('link').text,
                     :description => node.xpath('description').text,
                     :date        => node.xpath('pubDate').text,
                     :artwork     => node.xpath('pandora:stationAlbumArtImageUrl').text,
                     :songSeed_song   => node.xpath('pandora:seeds/pandora:songSeed/pandora:song').text,
                     :songSeed_artist => node.xpath('pandora:seeds/pandora:songSeed/pandora:artist').text,
                     :composerSeed    => node.xpath('pandora:seeds/pandora:composerSeed/pandora:composer').text,
                     :artistSeed      => node.xpath('pandora:seeds/pandora:artistSeed/pandora:artist') }
      end
      station
    end
    
    def recent_activity
      doc = request(@user, "recentactivity")
      items = []
      doc.xpath('//rss/channel/item').each do |node|
        items << { :title       => node.xpath('title').text,
                   :link        => node.xpath('link').text,
                   :description => node.xpath('description').text,
                   :date        => node.xpath('pubDate').text,
                   :track       => node.xpath('mm:Track/dc:title').text,
                   :artist      => node.xpath('mm:Artist/dc:title').text,
                   :album       => node.xpath('mm:Album/dc:title').text,
                   :artwork     => node.xpath('pandora:albumArtUrl').text,
                   :station     => node.xpath('pandora:stationLink').text }
      end
      items
    end
  end
end