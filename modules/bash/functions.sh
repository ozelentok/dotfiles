function gs {
	query=""
	for arg in $*; do
		query=$query$arg+
	done
	firefox www.google.com/search?q=$query
}
