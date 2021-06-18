#!/usr/bin/env bash

exec "$@"
superset db upgrade
superset init