#!/bin/bash

NAME="bootcamp"                              #Name of the application (*)
DJANGODIR=/home/nishant/public_html/provider    # Django project directory (*)
NUM_WORKERS=4                                             # how many worker processes should Gunicorn spawn (*)
DJANGO_SETTINGS_MODULE=bootcamp.settings             # which settings file should Django use (*)
DJANGO_WSGI_MODULE=bootcamp.wsgi                     # WSGI module name (*)
LOGFILE=/home/nishant/public_html/logs/gunicorn.log
echo "Starting $NAME as `whoami`"

# Activate the virtual environment
cd $DJANGODIR
source /home/nishant/ve/bin/activate
export DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE
export PYTHONPATH=$DJANGODIR:$PYTHONPATH


# Start your Django Unicorn
# Programs meant to be run under supervisor should not daemonize themselves (do not use --daemon)
exec /home/nishant/ve/bin/gunicorn ${DJANGO_WSGI_MODULE}:application \
  --name $NAME \
  --workers $NUM_WORKERS \
  --log-level=debug \
  --bind unix:/home/nishant/public_html/provider/provider.sock \
  --log-file=$LOGFILE 2>>$LOGFILE

