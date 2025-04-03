# README

This README would normally document whatever steps are necessary to get the
application up and running.


## Setup OpenWeather API client
```
require 'dotenv/load'
client = OpenWeather::Client.new(api_key: ENV['OPENWEATHER_API_KEY'])
weather = client.current_weather(city: 'Silver Spring', country: 'US', units: 'metric', lang: 'en')
```

### Dependencies

* Ruby version
3.4.2

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
