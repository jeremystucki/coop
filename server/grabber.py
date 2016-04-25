import re

import datetime
import pymongo
import requests
from bs4 import BeautifulSoup

db = pymongo.MongoClient().get_database('coop')
menus = []


def get_data_for_restaurant(restaurant_id, name):
    url = 'http://www.coop.ch/pb/site/restaurant/node/73195219/Lde/index.html'
    headers = {
        'Cookie': 'mapstart-restaurant=' + restaurant_id,
        'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.110 Safari/537.36'
    }

    data = requests.get(url, headers=headers)
    dom = BeautifulSoup(data.text, 'html.parser')

    weekdays = []

    for element in dom.find_all('span', {'id': re.compile('^tab-restaurant-\d$')}):
        year = datetime.datetime.now().year
        timestamp = datetime.datetime.strptime(element.contents[0][3:] + str(year), '%d.%m%Y').timestamp()
        weekdays.append(timestamp)

    for index, table in enumerate(dom.find_all('table', {'class': 'outer'})):
        for row in table.find_all('tr', recursive=False):
            menu_tag = row.find('td', {'class': 'inner col1'}).contents
            menu = [item for item in menu_tag if isinstance(item, str)]

            title_tag = row.find('td', {'class': 'outer col1'}).contents
            title = title_tag[0]

            price_tag = row.find('td', {'class': 'outer col3'}).contents
            price = price_tag[0]

            menus.append({
                'location': name,
                'menu': menu,
                'price': float(price),
                'timestamp': weekdays[index],
                'title': title
            })


get_data_for_restaurant('2524', 'Baden')
get_data_for_restaurant('2042', 'Aarau')

db.get_collection('menus_temp').insert_many(menus)
db.get_collection('menus_temp').rename('menus', dropTarget=True)
db.get_collection('menus').create_index(('location', pymongo.ASCENDING))
