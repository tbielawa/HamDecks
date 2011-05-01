BEGIN {
    INQ="no"
}

{
    # Why is it so hard to match an actual '(' or ')' character?
    if ($2 ~ "^[(][A-D][)]$") {
	INQ="yes"
	# Something like (a) is an answer and indicates a question
	# header begins here.
	ANS=substr($2, 2, 1)
	CAT=$1
	NS="QLINE" # The next parser state is the question line
	HEADER=$0
	sub(" [(]"ANS"[)] ?", " ", HEADER)
	print "  <item>"
	print "    <cat>" CAT "</cat>"
	print "    <Q>" HEADER
	next
    }

    if (NS ~ "QLINE") {
	# The last line evaluated was a question header which means
	# this state is the question.
	NS="" # Unset next state so we're not evaulated again
	print "       " $0
	next
    }	

    if ($1 ~ "^[A-D]\.$") {
	# Possible answer
	if ($1 ~ "^"ANS"\.$") {
	    # The actual answer
	    ANSTEXT=$0
	}
	print "       " $0
	next
    }

    if ($1 ~ "^~" || $1 ~ "^$") {
	if (INQ == "yes") {
	    # We only want to print this stuff once
	    INQ="no"
	    # We have reached the end of a question
	    print "    </Q>"
	    print "    <A>" ANSTEXT "</A>"
	    print "  </item>"
	    next
	}
    }
}
