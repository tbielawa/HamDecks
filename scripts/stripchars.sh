#!/bin/bash

# Copyright © 2013 Glenn Willen <gwillen@nerdnet.org>

# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following
# conditions:

# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.

# This file is part of "HamDecks": https://github.com/tbielawa/HamDecks

# Translate Latin-1 smart quotes and en-dash into UTF-8. There is probably a
# better way to do this.
LANG=C sed -e s/$'\x92'/$'\xe2\x80\x99'/g -e s/$'\x93'/$'\xe2\x80\x9c'/g -e s/$'\x94'/$'\xe2\x80\x9d'/g -e s/$'\x96'/-/g -e s/$'\xa0'/' '/g -e s/$'\xff'/' '/g
