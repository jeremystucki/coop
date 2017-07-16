import json
from datetime import datetime

import flask
import pymongo
import pytz
from flask import Flask

from locations import LocationsDAO
from menus import MenusDAO

app = Flask(__name__)

db = pymongo.MongoClient().get_database('coop')
locationsDAO = LocationsDAO(db.get_collection('locations'))
menusDAO = MenusDAO(db.get_collection('menus'))


@app.route('/coop/api/v2/locations/<id>')
@app.route('/coop/api/v2/restaurants/<id>')
def get_locations_by_id(id: str = None):
    try:
        location_id = int(id)
        location = locationsDAO.get_location(location_id)

        if location is None:
            return flask.Response(json.dumps({'error': 'no location found'}), status=404, mimetype='application/json')

        return flask.jsonify(location)
    except Exception:
        return flask.Response(json.dumps({'error': 'id must be an integer'}), status=400, mimetype='application/json')


@app.route('/coop/api/v2/locations')
@app.route('/coop/api/v2/restaurants')
def get_locations():
    args = flask.request.args
    longitude, latitude, query, limit = (None,)*4

    if 'limit' in args:
        try:
            limit = int(args['limit'])
        except Exception:
            return flask.Response(json.dumps({'error': 'limit must be an integer'}), status=400, mimetype='application/json')

    if ('latitude' in args) ^ ('longitude' in args):
        return flask.Response(json.dumps({'error': 'must provide latitude and longitude'}), status=400, mimetype='application/json')

    if 'latitude' in args and 'longitude' in args:
        try:
            longitude = float(args['longitude'])
            latitude = float(args['latitude'])
        except Exception:
            return flask.Response(json.dumps({'error': 'latitude and longitude must be numbers'}), status=400, mimetype='application/json')

    query = args['query'] if 'query' in args else ''

    if longitude and latitude:
        data = locationsDAO.get_locations_with_coordinates(longitude=longitude, latitude=latitude, limit=limit)
    else:
        data = locationsDAO.get_locations(search_text=query, limit=limit)

    return flask.jsonify({'results': data})


@app.route('/coop/api/v2/locations/<id>/menus')
@app.route('/coop/api/v2/locations/<id>/menus/<timestamp>')
@app.route('/coop/api/v2/restaurants/<id>/menus')
@app.route('/coop/api/v2/restaurants/<id>/menus/<timestamp>')
def get_menus(id: str, timestamp: str = None):
    args = flask.request.args

    try:
        location_id = int(id)
    except Exception:
        return flask.Response(json.dumps({'error': 'id must be an integer'}), status=400, mimetype='application/json')

    if timestamp is None and 'timestamp' in args:
        timestamp = args['timestamp']

    if timestamp == 'today':
        date = datetime.now(tz=pytz.utc).replace(hour=0, minute=0, microsecond=0)
        timestamp = date.timestamp()

    if timestamp is not None:
        try:
            timestamp = int(timestamp)
        except Exception:
            return flask.Response(json.dumps({'error': 'timestamp must be an integer'}), status=400, mimetype='application/json')

    return flask.jsonify({'results': menusDAO.get_menus(location=location_id, timestamp=timestamp)})


if __name__ == '__main__':
    app.run('0.0.0.0', '8080')
