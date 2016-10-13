import json

import flask
import pymongo
from flask import Flask, Response

app = Flask(__name__)

db = pymongo.MongoClient().get_database('coop')


@app.route('/api/v1/coop/menus')
def all_menus():
    return flask.jsonify({'results': list(db.get_collection('menus').find({}, {'_id': 0, 'location_lower': 0}))})


@app.route('/api/v1/coop/menus/<location>')
def menus_for_location(location):
    return flask.jsonify({'results': list(db.get_collection('menus')
                                          .find({'location_lower': location.lower()}, {'_id': 0, 'location': 0, 'location_lower': 0, 'location_id': 0}))})


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
                         .find({'location_lower': location.lower(), 'timestamp': int(timestamp)},
                               {'_id': 0, 'location': 0, 'timestamp': 0, 'location_lower': 0, 'location_id': 0}))})


def get_limit(arguments):
    if 'limit' not in arguments:
        return 20

    if arguments['limit'] == 'none':
        return None

    return int(arguments['limit'])


@app.route('/api/v1/coop/stats')
def stats():
    return flask.jsonify({'results': list(db.get_collection('menu_stats').find({}, {'_id': 0, 'location_lower': 0, 'location_id': 0}))})


def aggregate_stats(aggregation, request_params, location):
    pipeline = []

    if location is not None:
        pipeline.append({'$match': {'location_lower': location.lower()}})

    pipeline += aggregation

    if 'asc' in request_params:
        pipeline.append({'$sort': {'count': 1}})
    else:
        pipeline.append({'$sort': {'count': -1}})

    try:
        limit = get_limit(request_params)
    except ValueError:
        return Response(
            response=json.dumps({'results': [], 'error': 'limit is not an int or "none"'}),
            mimetype='application/json',
            status=400
        )

    if limit is not None:
        pipeline.append({'$limit': limit})

    return flask.jsonify({'results': list(db.get_collection('menu_stats').aggregate(pipeline))})


@app.route('/api/v1/coop/locations')
def locations():
    return flask.jsonify({'results': list(db.get_collection('menus').distinct('location'))})


@app.route('/api/v1/coop/stats/locations')
def stats_locations():
    return flask.jsonify({'results': list(db.get_collection('menu_stats').distinct('location'))})


@app.route('/api/v1/coop/stats/menus')
@app.route('/api/v1/coop/stats/menus/<location>')
def menu_stats(location=None):
    pipeline = [
        {
            '$group': {
                '_id': '$menu',
                'count': {'$sum': 1}
            }
        }, {
            '$project': {
                'menu': '$_id',
                '_id': 0,
                'count': 1
            }
        }
    ]

    return aggregate_stats(pipeline, flask.request.args, location)


@app.route('/api/v1/coop/stats/dishes')
@app.route('/api/v1/coop/stats/dishes/<location>')
def dishes_stats(location=None):
    pipeline = [
        {
            '$unwind': '$menu'
        },
        {
            '$group': {
                '_id': '$menu',
                'count': {'$sum': 1}
            }
        }, {
            '$project': {
                'menu': '$_id',
                '_id': 0,
                'count': 1
            }
        }
    ]

    return aggregate_stats(pipeline, flask.request.args, location)


@app.errorhandler(404)
def not_found(_):
    return flask.jsonify({'error': 'page not found'}), 404


if __name__ == '__main__':
    app.run('localhost', 8888)
