import flask
import pymongo
from flask import Flask

app = Flask(__name__)

db = pymongo.MongoClient().get_database('coop')


@app.route('/api/v1/coop/menus')
def all_menus():
    return flask.jsonify({'results': list(db.get_collection('menus').find({}, {'_id': 0}))})


@app.route('/api/v1/coop/menus/<location>')
def menus_for_location(location):
    return flask.jsonify({'results': list(db.get_collection('menus')
                                          .find({'location': location}, {'_id': 0, 'location': 0}))})


if __name__ == '__main__':
    app.run('localhost', 8888)
