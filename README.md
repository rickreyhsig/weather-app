# README

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
- `bin/rails test test/lib/weather_forecast_test.rb` # single test
- `bin/rails test` # full test suite

### Diagram
<img width="1079" alt="Screenshot 2025-04-06 at 10 30 57 PM" src="https://github.com/user-attachments/assets/0b211849-c000-482a-ba7c-bb0cb8ebdca6" />

### UI

| by zip cached | by city |
| --- | --- |
| <img width="364" alt="Screenshot 2025-04-06 at 10 34 31 PM" src="https://github.com/user-attachments/assets/fc078f92-e925-41ce-b37c-0b70f9db5eb3" /> | <img width="362" alt="Screenshot 2025-04-06 at 10 28 04 PM" src="https://github.com/user-attachments/assets/989fa5dc-335e-4577-a41e-07b7df52718f" />
 |

