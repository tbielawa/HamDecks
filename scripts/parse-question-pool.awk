# Copyright © 2011 Tim Bielawa <timbielawa@gmail.com>
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

BEGIN {
    INQ="no"
}

{
    if ($0 ~ "^[A-Z][0-9][A-Z] ") {
	# These indicate category's
	CAT=$1
	next
    }

    # Why is it so hard to match an actual '(' or ')' character?
    if ($2 ~ "^[(][A-D][)]$") {
	INQ="yes"
	# Something like (a) is an answer and indicates a question
	# header begins here.
	ANS=substr($2, 2, 1)
	NS="QLINE" # The next parser state is the question line
	HEADER=$0
	sub(" [(]"ANS"[)] ?", " ", HEADER)
	print "  <item>"
	print "    <cat>" CAT "</cat>"
	print "    <Q>" HEADER
	next
    }

    # Handle deleted questions, so we don't have to remove them as
    #   a preprocessing step.
    if ($1 ~ "Deleted") {
	INQ="yes"
	DELETED="yes"
	NS="QLINE"
	next
    }

    if (NS ~ "QLINE") {
	# The last line evaluated was a question header which means
	# this state is the question.
	NS="" # Unset next state so we're not evaulated again
	if (DELETED !~ "yes") {
	    print "       " $0
	}
	next
    }

    if ($1 ~ "^[A-D]\.$") {
	# Possible answer
	if ($1 ~ "^"ANS"\.$") {
	    # The actual answer
	    ANSTEXT=$0
	}
	if (DELETED !~ "yes") {
	    print "       " $0
	}
	next
    }

    if ($1 ~ "^~" || $1 ~ "^$") {
	if (INQ == "yes") {
	    # We only want to print this stuff once
	    INQ="no"
	    # We have reached the end of a question
	    if (DELETED !~ "yes") {
		print "    </Q>"
		print "    <A>" ANSTEXT "</A>"
		print "  </item>"
	    }
            # Reset for the next go-round.
            DELETED="no"
	    next
	}
    }

    if ($0 ~ "^SUBELEMENT") {
        # Ignore subelement headers
        next
    }

    if ($0 ~ "^[ \t]*$") {
        # Ignore blank line
        next
    }

    # The question pool data files have lots of formatting errors in them that we've manually corrected. If you get a fresh copy, this will help you in your quest to make it do something useful:
    print "unmatched line (possible error in input file) on line " NR ": " $0 > "/dev/stderr"
}
