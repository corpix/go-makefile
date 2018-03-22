.DEFAULT_GOAL = all

.PHONY: all
all: test

.PHONY: test
test:
	./tests/*

.PHONY: lint
lint:
	pyflakes go-makefile
