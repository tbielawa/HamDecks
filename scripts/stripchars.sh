#!/bin/bash

# Translate Latin-1 smart quotes and en-dash into UTF-8. There is probably a
# better way to do this.
LANG=C sed -e s/$'\x92'/$'\xe2\x80\x99'/g -e s/$'\x93'/$'\xe2\x80\x9c'/g -e s/$'\x94'/$'\xe2\x80\x9d'/g -e s/$'\x96'/$'\xe2\x80\x93'/g -e s/$'\xa0'/' '/g -e s/$'\xff'/' '/g
