import datetime
import json
import re
import pymongo
import requests
# noinspection PyPackageRequirements
from bs4 import BeautifulSoup

url = 'http://www.coop.ch/de/services/standorte-und-oeffnungszeiten.getvstlist.json?lat=47.0547336&lng=8.2122653&start=1&end=1000&filterFormat=restaurant&filterAttribute=&filterOpen=true&gasIndex=0'
db = pymongo.MongoClient('mongodb').get_database('coop')

response = requests.get(url)
data = json.loads(response.text)

timestamp = datetime.datetime.now()

for restaurant in data['vstList']:
    db_objc = {
        '_id': restaurant['betriebsNummerId']['id'],
        'coordinates': {
            'type': 'Point',
            'coordinates': [restaurant['longitude'], restaurant['latitude']]
        },
        'address': {
            'street': restaurant['strasse'],
            'house_number': restaurant['hausnummer'],
            'city': restaurant['ort'],
            'zip': int(restaurant['plz'])
        },
        'name': restaurant['name'],
        'lowercased_name': restaurant['name'].lower(),
        'last_updated': timestamp,
        'open': True
    }

    db.get_collection('locations').update({'_id': db_objc['_id']}, {'$set': db_objc}, upsert=True)

db.get_collection('locations').update({'last_updated': {'$ne': timestamp}}, {'$set': {'open': False}})
db.get_collection('locations').ensure_index([('coordinates', '2dsphere'), ('open', pymongo.ASCENDING)])
db.get_collection('locations').ensure_index([('name', pymongo.TEXT)], default_language='german')
db.get_collection('locations').ensure_index([('open', pymongo.ASCENDING)])
db.get_collection('locations').ensure_index([('last_updated', 1)], expireAfterSeconds=1209600)  # two weeks


# noinspection PyShadowingNames
def getMenusForData(response: requests.Response, location: dict):
    dom = BeautifulSoup(response.text, 'html.parser')

    menus = []
    weekdays = []

    for element in dom.find_all('span', {'id': re.compile('^tab-restaurant-\d$')}):
        year = datetime.datetime.now().year
        date = datetime.datetime.strptime(element.contents[0][3:] + str(year), '%d.%m%Y')
        weekdays.append(date)

    for index, table in enumerate(dom.find_all('table', {'class': 'outer'})):
        for row in table.find_all('tr', recursive=False):
            menu_tag = row.find('td', {'class': 'inner col1'}).contents
            menu = [item for item in menu_tag if isinstance(item, str)]

            title_tag = row.find('td', {'class': 'outer col1'}).contents
            title = title_tag[0]

            price_tag = row.find('td', {'class': 'outer col3'}).contents
            price = price_tag[0]

            menus.append({
                'location_id': int(location['_id']),
                'location': location['name'],
                'location_lower': location['name'].lower(),
                'menu': menu,
                'price': float(price),
                'timestamp': weekdays[index],
                'title': title
            })

    if len(menus) > 0:
        db.get_collection('menus_temp').insert(menus)


for location in list(db.get_collection('locations').find()):
    headers = {
        'Cookie': 'mapstart-restaurant=' + str(location['_id']),
        'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.110 Safari/537.36'
    }

    response = requests.get('http://www.coop.ch/pb/site/restaurant/node/73195219/Lde/index.html', headers=headers)
    getMenusForData(response, location)

    response = requests.get('http://www.coop.ch/pb/site/restaurant/node/73195219/Lde/index.html?nextWeek=true',
                            headers=headers)
    if response.status_code == 200:
        getMenusForData(response, location)

db.get_collection('menus_temp').create_index([('location_id', pymongo.ASCENDING), ('timestamp', pymongo.ASCENDING)])
db.get_collection('menus_temp').rename('menus', dropTarget=True)
