# = Pandora
# Defines all the methods related to getting data from Pandora.
#
module Pandora
  # The Request starts here with parsing the method call from 'user' and Nokogiri processing
  # the XML file.
  #
  module Request
    # The link to the Pandora XML files used throughout 
    BASE_FEED = "http://feeds.pandora.com/feeds/people/" 
    
    # The 'user' can only be a public user on pandora, who hasn't set listening activity to private.
    # The method comes from user requests. 
    # [String, String]
    #
    def request(user, method)
      doc = Nokogiri::XML(open("#{BASE_FEED}#{user}/#{method}.xml"))
    end
  end
end