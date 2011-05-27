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
This gem only works for public users. All users who did not set 'make my listening activity private'.

Usage Examples
--------------
    require "rubygems"
    require "pandora"

    # Initialize a new User with the Pandora username
    user = Pandora::User.new("joe")

    # Get a user's bookmarked songs
    songs = user.bookmarked_songs 	  # iterate over the songs array for each song

	# Get a user's bookmarked artits
	artists = user.bookmarked_artists # iterate over the artists array for each artist
	
	# Get a user's stations
	stations = user.stations 		  # iterate over the stations array for each station
	
	# Get a user's now playing station
	station = user.now_playing
	
	# Get a user's recent activity
	items = user.recent_activity
	
TODO
----
* TESTS!!!


