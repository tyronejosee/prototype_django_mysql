#!/bin/bash
set -e

echo "Starting Django with MySQL..."

# Apply database migrations
python manage.py migrate

# Start the server
exec python manage.py runserver 0.0.0.0:8000
