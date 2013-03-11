#!/bin/bash

echo "Running Drei in Production"
export PRODUCTION_SETTINGS=prod_settings.cfg
gunicorn app:app
