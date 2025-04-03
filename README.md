# README

This README would normally document whatever steps are necessary to get the
application up and running.

### Dependencies

#### Ruby version
3.4.2

#### Rails version
8.0.2

### Configuration

#### Setup OpenWeather API client
```
## Set your key in .env
# OPENWEATHER_API_KEY=<key>

## rails c
require 'dotenv/load'
client = OpenWeather::Client.new(api_key: ENV['OPENWEATHER_API_KEY'])
weather = client.current_weather(city: 'Silver Spring', country: 'US', units: 'metric', lang: 'en')
```

#### Database creation & init
bin/rails db:migrate

#### Lint
bin/rubocop

#### How to run the test suite

#### Services (job queues, cache servers, search engines, etc.)

#### Deployment instructions

#### ...
