#!/bin/bash

echo "Starting Drei in Production Mode"
export PRODUCTION_SETTINGS=prod_settings.cfg
gunicorn -b 127.0.0.1:8000 app:app
