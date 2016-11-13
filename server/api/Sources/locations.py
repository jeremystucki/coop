import pymongo


class LocationsDAO:
    def __init__(self, collection: pymongo.collection.Collection):
        self.collection = collection

    # noinspection PyShadowingBuiltins
    def get_location(self, id: int):
        return self.collection.find_one({
            '_id': id
        }, {
            'address': 1,
            'coordinates': 1,
            'name': 1,
            'open': 1
        })

    def get_locations(self, search_text: str = '', limit: int = None) -> list:
        query = {}
        projection = {
            '_id': 1,
            'address': 1,
            'coordinates': 1,
            'name': 1,
            'open': 1
        }

        if search_text != '':
            query['$text'] = {'$search': search_text},

        cursor = self.collection.find(query, projection)

        if limit is None:
            return list(cursor)

        return list(cursor.limit(limit))

    def get_locations_with_coordinates(self, longitude: float, latitude: float, limit: int = None) -> list:
        pipeline = [
            {
                '$geoNear': {
                    'near': {
                        'type': 'Point',
                        'coordinates': [longitude, latitude]
                    },
                    'spherical': True,
                    'distanceField': 'distance',
                }
            }, {
                '$project': {
                    '_id': 1,
                    'address': 1,
                    'name': 1,
                    'open': 1,
                    'distance': 1,
                    'coordinates': 1
                }
            }
        ]

        if limit is not None:
            pipeline.append({'$limit': limit})

        return list(self.collection.aggregate(pipeline))
