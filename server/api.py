import json

import flask
import pymongo
from flask import Flask, Response

app = Flask(__name__)

db = pymongo.MongoClient().get_database('coop')


@app.route('/api/v1/coop/menus')
def all_menus():
    return flask.jsonify({'results': list(db.get_collection('menus').find({}, {'_id': 0}))})


@app.route('/api/v1/coop/menus/<location>')
def menus_for_location(location):
    return flask.jsonify({'results': list(db.get_collection('menus')
                                          .find({'location': location}, {'_id': 0, 'location': 0}))})


@app.route('/api/v1/coop/menus/<location>/<timestamp>')
def menus_for_location_and_timestamp(location, timestamp):
    try:
        int(timestamp)
    except ValueError:
        return Response(
            response=json.dumps({'results': [], 'error': 'timestamp is not an int'}),
            mimetype='application/json',
            status=400
        )

    return flask.jsonify(
        {'results': list(db.get_collection('menus')
                         .find({'location': location, 'timestamp': int(timestamp)},
                               {'_id': 0, 'location': 0, 'timestamp': 0}))})


@app.errorhandler(404)
def not_found(_):
    return flask.jsonify({'error': 'page not found'}), 404


if __name__ == '__main__':
    app.run('localhost', 8888)
