{
    if ($2 ~ "^-$") {
	# These indicate category's
	CAT=$1
	print "  <category active=\"1\">"
	print "    <name>" $1 "</name>"
	print "  </category>"
	next
    }
}
