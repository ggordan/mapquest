# MapQuest [![Build Status](https://travis-ci.org/ggordan/mapquest.png?branch=master)](https://travis-ci.org/ggordan/mapquest)

A gem to communicate with the MapQuest web services.

API Key
----
To get an API key visit [http://developer.mapquest.com](http://developer.mapquest.com)

## Installation

Add this line to your application's Gemfile:

    gem 'mapquest'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mapquest

## Usage

    require 'mapquest'

    # Instantiate the API using an API key
    mapquest = MapQuest.new API_KEY

    # Get geolocation data
    data = mapquest.geocoding.decode :location => "London, UK"

    # Get lat/long coordinates of all the locations found
    data.locations.each { |location| puts location[:latLng] }


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
