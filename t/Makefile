.SUFFIXES:

check: bats-core
	./bats-core/bin/bats *.bats

bats-core:
	git clone https://github.com/bats-core/bats-core
	git -C bats-core checkout 90a051bf2d58432348002091bc6eb0c202a3eee7
