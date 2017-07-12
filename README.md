go-makefile
------------------

[![Build Status](https://travis-ci.org/corpix/go-makefile.svg?branch=master)](https://travis-ci.org/corpix/go-makefile)

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

Two kinds of Makefiles could be generated by this tool:

- package
- application

Each of them will contain rules for corresponding entity.

Application `Makefile` will contain everything the package needs but not vice versa.

> Kinds could be simplified until they are not ambiguous, for example: <br/>
> `application -> app  -> a` <br/>
> `package     -> pack -> p` <br/>

``` shell
go-makefile --kind app --user your-name --name project-name > Makefile
```

This will write content to the `Makefile` in the current directory.

--------------------------------------------------------------------------------------

If you need additional tools to be installed automatically by `Makefile` then
you could pass `--tool` parameter in this manner:

``` shell
go-makefile                        \
    --kind app                     \
    --user your-name               \
    --name project-name            \
    --tool                         \
    github.com/corpix/awesome-tool \
    github.com/corpix/way-cooler-tool
```

All of them will be appended to the list of the tools which installed by default.

--------------------------------------------------------------------------------------

If you need additional includes you could pass `--include` parameter in this manner:

``` shell
go-makefile             \
    --kind app          \
    --user your-name    \
    --name project-name \
    --include           \
    build.mk            \
    ci.mk
```

All of them will be appended to the list of the includes which will be appended to the end of the `Makefile`.

## Saving configuration

You could save parameters which was used to generate `Makefile`.

There are `--read-config` and `--write-config` arguments.

To write your config while generating `Makefile` you could use:

``` shell
go-makefile --kind app --user your-name --name project-name --write-config go-makefile.json
```

To read previously stored config and use them to generate `Makefile`:

``` shell
go-makefile --read-config go-makefile.json
```

## Goals

Each goal is a [double-colon](https://www.gnu.org/software/make/manual/html_node/Double_002dColon.html) rule so
you could define your custom logic for any `Makefile` rule using includes.

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
