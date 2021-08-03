gunicorn "superset.app:create_app()"
sleep 1m
superset db upgrade
superset init