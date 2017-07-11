go-makefile
------------------

Little tool to generate a `Makefile` for your project.

Use it to get a minimal boilerplate with a `Makefile` for your project.

# Project layout

To make it work out of the box project should have layout like this:

> Our example project name is `github.com/corpix/hello`.

``` text
~/go/src/github.com/corpix/hello
├── cli
│   └── cli.go
└── hello
    └── main.go
```

Where:

- `hello/main.go` is an entrypoint
- `cli/cli.go` is a part of the package `cli`

## `cli/cli.go`

It should have `version` variable to allow linker automatically tag a build with version.

``` go
package cli

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

- [glide](github.com/Masterminds/glide)
- [godef](github.com/rogpeppe/godef)
- [gocode](github.com/nsf/gocode)
- [testify/assert](github.com/stretchr/testify/assert)
- [gometalinter](github.com/alecthomas/gometalinter)
- and all linters supported my gometalinter

### `dependencies`

Install dependencies with glide.

### `test`

Will reach `tools` target after that will run tests for project package.

### `bench`

Will reach `tools` target after that will run tests and benchmarks for project package.

### `$(name)`

> Name of this target depends on the `--name` flag which you should specify to generate a `Makefile`.

It will build a binary release for the project.

## Variables

### `name`

Name of the project.

It depends on the `--name` flag which you should specify to generate a `Makefile`.

### `package`

Package of the project.

This is an absolute package name which should be used to import your project like any other go project would do.

It depends on the `--project` flag which you should specify to generate a `Makefile`.

### `numcpus`

Just a number of processor cores available on the current system.

### `version`

Version number retrieved from the git version control.

It will look like `100.abcdef` where:

- `100` is a commit count from the first commit to `HEAD`
- `abcdef` is a short `HEAD` sha1 sum

### `ldflags`

Linker flags.

It does two things:

- set the version into `$(PACKAGE)/cli.version` variable
- generates random `NT_GNU_BUILD_ID` which is useful to identify the build

# License

MIT
