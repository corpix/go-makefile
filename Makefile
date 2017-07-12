.DEFAULT_GOAL = all

.PHONY: all
all: test

.PHONY: test
test:
	./tests/*
