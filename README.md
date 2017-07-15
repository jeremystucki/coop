# Coop

## Clients

### iOS
The app is available from the [AppStore](https://appsto.re/ch/EAI0cb.i).

### telegram
The telegram bot is available [here](https://telegram.me/CoopMenuBot).

## API
The api is hosted at [themachine.jeremystucki.com](https://themachine.jeremystucki.com).

### Locations
`GET /coop/api/v2/locations`

#### Parameters
latitude and longitude | query | limit | description
--- | --- | --- | ---
-| - | - | Get all locations
X | - | _optional_ | Get all locations, sorted by distance
-| X | _optional_ | Get all locations, sorted by relevance

```json
{
  "results": [
    {
      "id": 2257,
      "name": "Kriens Schappe Bistro",
      "location": {
        "coordinates": [
          <long>,
          <lat>
        ],
        "address": {
          "city": "Kriens",
          "house_number": "2",
          "street": "Hobacherweg",
          "zip": 6010
        }
      }
    }, ...
  ]
}
```

### Location detail
`GET /coop/api/v2/locations/<id>`
```json
{
  "id": 2524,
  "name": "Baden",
  "location": {
    "coordinates": [
      <long>,
      <lat>
    ],
    "address": {
      "city": "Baden",
      "house_number": "28",
      "street": "Bahnhofstrasse",
      "zip": 5401
    }
  }
}
```

### Menus

#### All menus for location
`GET /coop/api/v2/locations/<id>/menus`

#### All menus for today
`GET /coop/api/v2/locations/<id>/menus/today`

#### All menus for a specific date
`GET /coop/api/v2/locations/<id>/menus/<timestamp>` // Midnight GMT

```json
{
  "results": [
    {
      "menu": [
        "Spare-Ribs",
        "BBQ-Sauce",
        "Baked Potatoes",
        "Maiskolben"
      ],
      "price": 13.95,
      "timestamp": 1493078400.0,
      "title": "Wochenmen\u00fc"
    }, ...
  ]
}
```

## Thanks to
[@bash](https://github.com/bash)
[@bauidch](https://github.com/bauidch)
[@randalf98](https://github.com/randalf98)
