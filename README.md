# Coop

## Supported locations
- Aarau
- Baden
- Egerkingen
- Lenzburg
- Olten
- Wettingen
- Zofingen

## API

The api is hosted at [themachine.jeremystucki.com](https://themachine.jeremystucki.com).

### Menus
#### /api/v1/coop/menus
```GET /api/v1/coop/menus```
```json
{
  "results": [
    {
      "location": "Baden",
      "menu": [
        "Kalbsbratwurst",
        "Zwiebelsauce",
        "R\u00f6sti",
        "Saisonsalat"
      ],
      "price": 12.95,
      "timestamp": 1461880800.0,
      "title": "Wochenmen\u00fc"
    }
  ]
}
```
Returns all menus for all restaurants.

#### /api/v1/coop/menus/\<location>
```GET /api/v1/coop/menus/Aarau```
```json
{
  "results": [
    {
      "menu": [
        "Kalbsbratwurst",
        "Zwiebelsauce",
        "R\u00f6sti",
        "Saisonsalat"
      ],
      "price": 12.95,
      "timestamp": 1461880800.0,
      "title": "Wochenmen\u00fc"
    }
  ]
}
```
Returns all menus for a given restaurant.

#### /api/v1/coop/menus/\<location>/\<timestamp>
```GET /api/v1/coop/menus/Aarau/1461967200```
```json
{
  "results": [
    {
      "menu": [
        "Kalbsbratwurst",
        "Zwiebelsauce",
        "R\u00f6sti",
        "Saisonsalat"
      ],
      "price": 12.95,
      "timestamp": 1461967200.0,
      "title": "Wochenmen\u00fc"
    }
  ]
}
```
Returns all menus for a given restaurant and timestamp (midnight).

### Stats
You can sort all stats ascending by passing ```asc``` as a query parameter.

You can also provide a limit. The default limit is 20.
The limit can also be set to none to get all data.

#### /api/v1/coop/stats
```GET /api/v1/coop/stats```
```json
{
  "results": [
    {
      "location": "Baden",
      "menu": [
        "Pouletflügeli",
        "BBQ-Sauce",
        "Kartoffel-Wedges"
       ],
      "price": 9.95,
      "timestamp": 1461794400,
      "title": "Special"
    }
  ]
}
```
Returns all menus for all restaurants for all timestamps.

#### /api/v1/coop/stats/menus
```GET /api/v1/coop/stats/menus```
```json
{
  "results": [
    {
      "count": 21,
      "menu": [
        "Pouletflügeli",
        "BBQ-Sauce",
        "Kartoffel-Wedges"
      ]
    }
  ]
}
```
Returns all menus and how many times they were listed for all restaurants for all timestamps.

#### /api/v1/coop/stats/menus/\<location>
```GET /api/v1/coop/stats/menus/Aarau```
```json
{
  "results": [
    {
      "count": 3,
      "menu": [
        "Kalbsbratwurst",
        "Zwiebelsauce",
        "Rösti",
        "Saisonsalat"
      ]
    }
  ]
}
```
Returns all menus and how many times they were listed for a given restaurant for all timestamps.

#### /api/v1/coop/stats/dishes
```GET /api/v1/coop/stats/dishes```
```json
{
  "results": [
    {
      "count": 48,
      "menu": "Saisonsalat"
    },
  ]
}
```
Returns all dishes and how many times they were listed for all restaurants for all timestamps.

#### /api/v1/coop/stats/dishes/\<location>
```GET /api/v1/coop/stats/dishes/Aarau```
```json
{
  "results": [
    {
      "count": 9,
      "menu": "Saisonsalat"
    }
  ]
}
```
Returns all dishes and how many times they were listed for a given restaurant for all timestamps.
