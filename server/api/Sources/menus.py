import datetime
import pymongo


class MenusDAO:

    def __init__(self, collection: pymongo.collection.Collection):
        self.collection = collection

    def get_menus(self, location: int, timestamp: int = None):
        query = {'location_id': location}
        projection = {
            '_id': 0,
            'title': 1,
            'menu': 1,
            'price': 1
        }

        if timestamp is not None:
            query['timestamp'] = timestamp
        else:
            projection['timestamp'] = 1

        return list(self.collection.find(query, projection))
