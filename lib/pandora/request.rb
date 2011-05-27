module Pandora
  module Request
    BASE_FEED = "http://feeds.pandora.com/feeds/people/"
    
    def request(user, method)
      doc = Nokogiri::XML(open("#{BASE_FEED}#{user}/#{method}.xml"))
    end
  end
end