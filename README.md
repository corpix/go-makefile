go-makefile
------------------

Little tool to generate a `Makefile` for your project.

Use it to get a minimal boilerplate with a `Makefile` for your project.

# Project layout

To make it work out of the box project should have layout like this:

> Our example project name is `github.com/corpix/hello`.

``` text
~/go/src/github.com/corpix/hello
├── cmd
│   └── cmd.go
└── hello
    └── main.go
```

Where:

- `hello/main.go` is an entrypoint
- `cmd/cmd.go` is a part of the package `cmd`

## `cmd/cmd.go`

It should have `version` variable to allow linker automatically tag a build with version.

``` go
package cmd

var version string

func Run() { ... }
```

# Usage

``` shell
go-makefile --user your-name --name project-name > Makefile
```

This will write content to the `Makefile` in the current directory.

## Goals

### `all`

By default it will install all required tools to the current `GOPATH` by reaching the `tools` goal.

### `tools`

Install required tools:

- [govendor](github.com/kardianos/govendor)
- [godef](github.com/rogpeppe/godef)
- [gocode](github.com/nsf/gocode)
- [testify/assert](github.com/stretchr/testify/assert)
- [gometalinter](github.com/alecthomas/gometalinter)
- and all linters supported my gometalinter

### `test`

Will reach `tools` and `lint` targets after that will run tests for project package.

### `$(NAME)`

> Name of this target depends on the `--name` flag which you should specify to generate a `Makefile`.

It will build a binary release for the project.

## Variables

### `NAME`

Name of the project.

It depends on the `--name` flag which you should specify to generate a `Makefile`.

### `PACKAGE`

Package of the project.

This is an absolute package name which should be used to import your project like any other go project would do.

It depends on the `--project` flag which you should specify to generate a `Makefile`.

### `NUMCPUS`

Just a number of processor cores available on the current system.

### `VERSION`

Version number retrieved from the git version control.

It will look like `100.abcdef` where:

- `100` is a commit count from the first commit to `HEAD`
- `abcdef` is a short `HEAD` sha1 sum

### `LDFLAGS`

Linker flags.

It does two things:

- set the version into `$(PACKAGE)/cmd.version` variable
- generates random `NT_GNU_BUILD_ID` which is useful to identify the build

# License

MIT
