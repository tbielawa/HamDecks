BEGIN {
    INQ="no"
}

{
    if ($2 ~ "^-$") {
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
}
