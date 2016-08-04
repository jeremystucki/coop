import datetime

import telepot
import time
import pymongo


# TODO refactor

bot = telepot.Bot('key')
collection = pymongo.MongoClient().get_database('coop').get_collection('menus')


def unix_time(dt):
    epoch = datetime.datetime.utcfromtimestamp(0)
    return int((dt - epoch).total_seconds()) - 7200


def handle(message):
    sender = message['chat']['id']

    if not message or message['text'] == '/start':
        return bot.sendMessage(sender, 'Hi, I can look up the menu plan of a coop restaurant for you. Just send me "/menus LOCATION" and I will look it up.')

    if message['text'][:7] != '/menus ':
        return bot.sendMessage(sender, 'Sorry, I don\'t understand. Please use the "/menus LOCATION" syntax.')

    location = message['text'][7:]

    current_day = unix_time(datetime.datetime.combine(datetime.datetime.now().date(), datetime.time()))
    menus = collection.find({'location_lower': location.lower(), 'timestamp': current_day})

    if menus.count() == 0:
        return bot.sendMessage(sender, 'Sorry, I did not find any menus for {} today'.format(location))

    response = ''

    for menu in menus:
        response += '*{}* - _{}_'.format(menu['title'], menu['price'])
        for dish in menu['menu']:
            response += '\n{}'.format(dish)

        response += '\n\n'

    bot.sendMessage(sender, response, parse_mode='Markdown')


bot.message_loop(handle)

while 1:
    time.sleep(10)
