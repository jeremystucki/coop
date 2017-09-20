import requests
import telepot
import time
import os

bot = telepot.Bot(os.environ['TELEGRAM_API_KEY'])
base_url = 'https://themachine.jeremystucki.com/coop/api/v2'


def format_locations(locations: [dict]) -> str:
    return '\n'.join(['/{} {}'.format(location['id'], location['name']) for location in locations])


def format_menu(menu: dict) -> str:
    return '*{}* - _{}_\n'.format(menu['title'], menu['price']) + '\n'.join(['{}'.format(dish) for dish in menu['menu']])


def format_menus(menus: [dict]) -> str:
    return '\n\n'.join([format_menu(menu) for menu in menus])


def get_locations_for_coorinates(coordinates: dict) -> [dict]:
    return requests.get('{}/locations'.format(base_url), params=coordinates).json()['results']


def get_locations_for_query(query: str) -> [dict]:
    return requests.get('{}/locations'.format(base_url), params={'query': query}).json()['results']


def get_location_for_id(id: int) -> dict:
    response = requests.get('{}/locations/{}'.format(base_url, id))

    if response.status_code != 404:
        return response.json()


def get_menus_for_location_id(location_id: int) -> [dict]:
    return requests.get('{}/locations/{}/menus/today'.format(base_url, location_id)).json()['results']


def handle(message: dict):
    sender = message['chat']['id']

    if 'location' in message:
        bot.sendChatAction(sender, 'typing')

        locations = get_locations_for_coorinates(message['location'])
        message = '*Ich habe einige Standorte in der Nähe gefunden*\n' + format_locations(locations[:4])
        return bot.sendMessage(sender, message, parse_mode='Markdown')

    if 'entities' in message and message['entities'][0]['type'] == 'bot_command':
        try:
            location_id = int(message['text'][1:5])
            bot.sendChatAction(sender, 'typing')

            location = get_location_for_id(location_id)
            if location is None:
                return bot.sendMessage(sender, 'Ich konnte diesen Standort nicht finden')

            menus = get_menus_for_location_id(location['id'])
            if len(menus) == 0:
                return bot.sendMessage(sender, 'Ich konnte keine Menüs für {} finden'.format(location['name']))

            message = '*Menüs für {}*\n'.format(location['name'])
            message += format_menus(menus)

            return bot.sendMessage(sender, message, parse_mode='Markdown')
        except ValueError:
            pass

    if 'text' in message and message['text'].startswith('/menus'):
        bot.sendChatAction(sender, 'typing')

        query = ' '.join(message['text'].split()[1:])
        locations = get_locations_for_query(query)

        if query == '':
            return bot.sendMessage(sender, 'Du hast mir keinen Standort angegeben.\n'
                                   + 'Scbreibe entweder eine Nachricht mit "/menus STANDORT" oder sende deinen Standort',
                                   parse_mode='Markdown')

        if len(locations) == 0:
            bot.sendMessage(sender, 'Ich konnte diesen Standort nicht finden')
            return bot.sendMessage(sender, 'Wenn du deinen Standort sendest, kann ich ein Restaurant in der Nähe finden')

        if len(locations) == 1:
            menus = get_menus_for_location_id(locations[0]['id'])
            if len(menus) == 0:
                return bot.sendMessage(sender, 'Ich konnte keine Menüs für {} finden'.format(locations[0]['name']))

            message = '*Menüs für {}*\n'.format(locations[0]['name'])
            message += format_menus(menus)
            return bot.sendMessage(sender, message, parse_mode='Markdown')

        if len(locations) > 1:
            message = '*Ich habe mehrere Standorte unter diesem Namen gefunden*\n' + format_locations(locations[:4])
            return bot.sendMessage(sender, message, parse_mode='Markdown')


bot.message_loop(handle)

while 1:
    time.sleep(10)
