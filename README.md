The Pandora Ruby Gem
====================
A Ruby wrapper for the Pandora public user feeds


Installation
------------
    gem install pandora

Documentation
-------------
[http://rdoc.info/gems/pandora](http://rdoc.info/gems/pandora)

Usage
-----
This gem only works for public user's; All users did not set 'make my listening activity private'

Usage Examples
--------------
    require "rubygems"
    require "pandora"

    # Initialize a new User
    user = Pandora::User.new("anil")

    # Get a user's bookmarked songs
    songs = user.bookmarked_songs 	 # iterate over the songs array for each song

	# Get a user's bookmarked artits
	artists = user.bookmarked_artist # iterate over the artists array for each artist
	
	# Get a user's stations
	stations = user.stations 		 # iterate over the stations array for each station
	
	# Get a user's station(now playing)
	station = user.now_playing
	
	# Get a user's recent activity
	activity = user.recent_activity


