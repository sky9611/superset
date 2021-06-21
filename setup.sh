#!/usr/bin/env bash

set -e

# Launch superset
gunicorn "superset.app:create_app()"

# Create an admin user
superset fab create-admin --username admin --firstname Superset --lastname Admin --email admin@superset.com --password admin

# Initialize the database
superset db upgrade

# Create default roles and permissions
superset init