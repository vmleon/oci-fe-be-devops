#!/bin/bash
/usr/bin/python3 -m gunicorn \
  --bind 0.0.0.0:3000 \
  -w 2 \
  wsgi:app