# README

## Learning Goals

- Expose an API that aggregates data from multiple external APIs
- Expose an API that requires an authentication token
- Expose an API for CRUD functionality
- Determine completion criteria based on the needs of other developers
- Test both API consumption and exposure, making use of VCR for request stubbing.

## Getting Started

- Fork this repository to your GitHub account.
- Clone your forked repository by clicking on code and copying your SSH URL and typing 'git clone < your Github SSH >' into your terminal.
- Navigate into the newly cloned folder and type 'rails s' into your terminal to start your local server.
- In your preferred API consumption software, make a post request to 'localhost:3000/users' with the info below as the payload to register an API key. Note: minimum password length is 8 characters.
  
  - Headers: Content-Type: application/json Accept: application/json
  - {
      "email": < your email >,
      "password": < chosen password >,
      "password_confirmation": < chosen password >
    }

- You will be returned your newly registered API key. Should you ever lose this key you may use the sessions endpoint to login and retreive it. Smooth sailing and enjoy your roadtrip!

## Endpoints

### /forecast

- This endpoint returns weather data from a get request for a specific location (more details below).
  - Location parameter (required): this parameter accepts a location in the format < city,state >
  - Return data: returns current weather conditions, daily forecast for the next 5 days and hourly forecasts for the entire current day. Play around to learn more!

### /users

- This endpoint allows registration of a new API key by making a post request with a valid email and password (and confirmation).
  - Payload: 
    {
      "email": < your email >,
      "password": < chosen password >,
      "password_confirmation": < chosen password >
    }
  - Headers: 'Content-Type: application/json Accept: application/json'

### /sessions

- This endpoint allows the user to retreive their API key with a post request containing their login credentials. This endpoint could be used for a FE login functionality.
  - Payload: 
    {
      "email": < your email >,
      "password": < your password >
    }
  - Headers: 'Content-Type: application/json Accept: application/json'

### /road_trip

- This endpoint allows the user to create a roadtrip with a post request and returns food and weather information about the destination as well as providing the total estimated trip time. 
  - Payload: 
    {
      "origin": < trip origin >,
      "destination": < trip destination >,
      "api_key": < your API key >
    }
  - Headers: 'Content-Type: application/json Accept: application/json'
  - Return data: starting city, ending city, estimated travel time, estimated arrival time, forecasted temperature at destination, forecasted conditions at destination. Example data below
  - {
    "data": {
        "id": "null",
        "type": "road_trip",
        "attributes": {
            "start_city": "Cincinatti, OH",
            "end_city": "Chicago, IL",
            "travel_time": "04:40:45",
            "weather_at_eta": {
                "datetime": "2023-04-07 23:00",
                "temperature": 44.2,
                "condition": "Cloudy with a chance of meatballs"
            }
        }
    }
}
