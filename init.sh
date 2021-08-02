service ssh start
gunicorn "superset.app:create_app()"
superset db upgrade
superset init