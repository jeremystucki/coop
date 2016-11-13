import datetime
import requests
import telepot
import time


# TODO refactor

bot = telepot.Bot('<key>')


def unix_time(dt):
    epoch = datetime.datetime.utcfromtimestamp(0)
    return int((dt - epoch).total_seconds())


def handle(message):
    sender = message['chat']['id']

    if not message or message['text'] == '/start':
        return bot.sendMessage(sender, 'Hi, I can look up the menu plan of a coop restaurant for you. Just send me "/menus LOCATION" and I will look it up.')

    if message['text'][:7] != '/menus ':
        return bot.sendMessage(sender, 'Sorry, I don\'t understand. Please use the "/menus LOCATION" syntax.')

    location = message['text'][7:]

    current_day = unix_time(datetime.datetime.combine(datetime.datetime.now().date(), datetime.time()))

    print(current_day)

    menus = requests.get('https://themachine.jeremystucki.com/api/v1/coop/menus/{}/{}'.format(location, current_day)).json()['results']

    if not menus:
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
