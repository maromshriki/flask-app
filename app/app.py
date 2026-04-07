from flask import Flask
import psycopg2
import os

app = Flask(__name__)

# ✅ קבלת משתני סביבה
DB_HOST = os.environ.get("POSTGRES_HOST")
DB_USER = os.environ.get("POSTGRES_USER")
DB_PASS = os.environ.get("POSTGRES_PASSWORD")
DB_NAME = os.environ.get("POSTGRES_DB")

def get_db_version():
    try:
        conn = psycopg2.connect(
            host=DB_HOST,
            user=DB_USER,
            password=DB_PASS,
            dbname=DB_NAME
        )
        cur = conn.cursor()
        cur.execute("SELECT version();")
        version = cur.fetchone()[0]
        cur.close()
        conn.close()
        return version
    except:
        return "DB not ready"

@app.route("/")
def home():
    db_version = get_db_version()
    return f"<h1>🚀 Flask Production-like App</h1><p>Postgres version: {db_version}</p>"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)