module Pandora
  class User
    include Pandora::Request
    
    attr_accessor :user
    
    def initialize(user)
      @user = user.strip
    end
    
    def favorite_songs(songs=[])
      doc = @user.request(@user, "favorites")
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
  end
end