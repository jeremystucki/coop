# Coop

## Supported locations
- Aarau
- Baden
- Egerkingen
- Lenzburg
- Olten
- Wettingen
- Zofingen

## Client

### Installation on OSX
There is a brew tap available for coop:

```bash
brew tap bash/homebrew-coop
brew install --HEAD coop
```

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
