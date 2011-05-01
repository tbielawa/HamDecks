{
    if ($2 ~ "^-$") {
	# These indicate category's
	print "  <category active=\"1\">"
	print "    <name>" $1 "</name>"
	print "  </category>"
	next
    }
}
