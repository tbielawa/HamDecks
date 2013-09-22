{
    if ($0 ~ "^[A-Z][0-9][A-Z] ") {
	# These indicate category's
	CAT=$1
	print "  <category active=\"1\">"
	print "    <name>" $1 "</name>"
	print "  </category>"
	next
    }
}
