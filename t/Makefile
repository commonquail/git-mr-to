.SUFFIXES:

check: bats-core
	./bats-core/bin/bats *.bats

bats-core:
	git clone https://github.com/bats-core/bats-core
	git -C bats-core checkout ddef6c3f5f790d1ad5b2386154b6d3e21165d034
