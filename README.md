# Coop

## Supported locations
- All


## Clients

### Installation on iOS
The app is available from the [AppStore](https://appsto.re/ch/EAI0cb.i).


### Installation on SailfishOS
The app is now available on your Jolla App Store.


### Installation on OSX
There is a brew tap [available](https://github.com/bash/homebrew-coop) for coop:

```bash
brew tap bash/homebrew-coop
brew install coop-rust
```


### Installation on Windows

#### Powershell
There is also a powershell module:

```powershell
Invoke-WebRequest -OutFile CoopInstaller.ps1 -Uri https://raw.githubusercontent.com/STJEREM/coop/development/client/powershell/Installer.ps1; .\CoopInstaller.ps1
```


### Cross-Platform

#### Java
There is a java application by [@randalf98](https://github.com/randalf98).

The jar can be downloaded [here](https://github.com/Randalf98/CoopApplication/releases).


#### Python
You can download the python script [here](https://github.com/STJEREM/coop/blob/development/client/python/coop).

#### Rust
A rust client is available at [bash/coop-rust](https://github.com/bash/coop-rust).

<br />


## API

The api is hosted at [themachine.jeremystucki.com](https://themachine.jeremystucki.com).

### Locations
#### /api/v1/coop/locations
```GET /api/v1/coop/locations```
```json
{
  "results": [
    "Baden",
    "Egerkingen",
    "Zofingen",
    "Olten",
    "Wettingen",
    "Lenzburg",
    "Aarau",
    "Frick",
    "Luzern",
    "Emmenbrücke"
  ]
}
```
Returns all supported locations.

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


<br />


## Thanks to
[@bash](https://github.com/bash)
[@bauidch](https://github.com/bauidch)
[@randalf98](https://github.com/randalf98)
