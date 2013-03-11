#!/bin/bash

echo "Running Drei in Production"
export PRODUCTION_SETTINGS=prod_settings.cfg
gunicorn -b 127.0.0.1:80 app:app
