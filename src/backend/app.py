import os
from flask import Flask
from flask import jsonify
import oracledb

app = Flask(__name__)

DB_USER = os.environ.get('DB_USER', 'ADMIN')
DB_PASSWORD = os.environ.get('DB_PASSWORD')
DB_SERVICE = os.environ.get('DB_SERVICE')

connection = oracledb.connect(
    user=DB_USER, password=DB_PASSWORD, dsn=DB_SERVICE)


@app.route('/database')
def index():
    cursor = connection.cursor()
    cursor.execute('SELECT SYSTIMESTAMP FROM DUAL;')
    timestamp_db = cur.fetchone()
    return jsonify(time=timestamp_db)
