load("@rules_go//go:def.bzl", "go_binary", "go_cross_binary")

go_cross_binary(
    name = "hello_rv64",
    platform = "//platform:rv64_linux",
    target = ":hello",
)

go_binary(
    name = "hello",
    srcs = ["hello.go"],
    cgo = True,
    cdeps = [
        ":c_hello",
    ],
    static = "on",
)

cc_library(
    name = "c_hello",
    hdrs = ["hello.h"],
    srcs = ["hello.c"],
)
