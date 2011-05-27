module Pandora
  module Request
    BASE_FEED = "http://feeds.pandora.com/feeds/people"
    
    def request(user, method)
      doc = Nokogiri::XML(open("http://feeds.pandora.com/feeds/people/#{user}/#{method}.xml"))
    end
  end
end