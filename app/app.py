from flask import Flask
import psycopg2
import os
import time

app = Flask(__name__)

DB_HOST = os.environ.get("POSTGRES_HOST")
DB_USER = os.environ.get("POSTGRES_USER")
DB_PASS = os.environ.get("POSTGRES_PASSWORD")
DB_PORT = os.environ.get("POSTGRES_PORT")

def get_db_version(retries=5, delay=3):
    for attempt in range(retries):
        try:
            conn = psycopg2.connect(
                host=DB_HOST,
                user=DB_USER,
                password=DB_PASS,
                port=DB_PORT
            )
            cur = conn.cursor()
            cur.execute("SELECT version();")
            version = cur.fetchone()[0]
            cur.close()
            conn.close()
            return version
        except Exception as e:
            print(f"DB connection failed (attempt {attempt+1}/{retries}): {e}")
            time.sleep(delay)
    return "DB not ready"

@app.route("/")
def home():
    db_version = get_db_version()
    return f"<h1>🚀 Flask Production--like Apps</h1><p>Postgres version: {db_version}</p>"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)