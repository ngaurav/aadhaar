#!/bin/bash

NAME="bootcamp"                              #Name of the application (*)
DJANGODIR=/root/public_html/finpulse.com    # Django project directory (*)
NUM_WORKERS=4                                             # how many worker processes should Gunicorn spawn (*)
DJANGO_SETTINGS_MODULE=bootcamp.settings             # which settings file should Django use (*)
DJANGO_WSGI_MODULE=bootcamp.wsgi                     # WSGI module name (*)
LOGFILE=/root/public_html/logs/gunicorn.log
echo "Starting $NAME as `whoami`"

# Activate the virtual environment
cd $DJANGODIR
source /root/ve/bin/activate
export DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE
export PYTHONPATH=$DJANGODIR:$PYTHONPATH


# Start your Django Unicorn
# Programs meant to be run under supervisor should not daemonize themselves (do not use --daemon)
exec /root/ve/bin/gunicorn ${DJANGO_WSGI_MODULE}:application \
  --name $NAME \
  --workers $NUM_WORKERS \
  --log-level=debug \
  --bind unix:/root/public_html/finpulse.com/finpulse.sock \
  --log-file=$LOGFILE 2>>$LOGFILE

