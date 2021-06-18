#!/usr/bin/env bash

gunicorn superset.app:create_app()
superset db upgrade
superset init