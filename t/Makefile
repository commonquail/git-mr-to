.SUFFIXES:


check: bats-core
	./bats-core/bin/bats *.bats

bats-core:
	git clone https://github.com/bats-core/bats-core
	git -C bats-core checkout 90a051bf2d58432348002091bc6eb0c202a3eee7
	git clone https://github.com/bats-core/bats-support
	git -C bats-support checkout d140a65044b2d6810381935ae7f0c94c7023c8c3
	git clone https://github.com/bats-core/bats-assert
	git -C bats-assert checkout 672ad1823a4d2f0c475fdbec0c4497498eec5f41
