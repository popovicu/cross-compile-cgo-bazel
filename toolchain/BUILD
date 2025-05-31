load(":rv64_toolchain.bzl", "rv64_linux_toolchain_config")

filegroup(name = "empty")

rv64_linux_toolchain_config(
    name = "rv64_linux_toolchain_config"
)

cc_toolchain(
    name = "rv64_linux_toolchain",
    toolchain_identifier = "riscv64-linux-gnu",
    toolchain_config = ":rv64_linux_toolchain_config",
    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
    supports_param_files = False,
)

toolchain(
    name = "riscv64_toolchain_from_linux_x86_64",
    exec_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
    target_compatible_with = [
        "@platforms//os:linux",
        # "@platforms//cpu:riscv64", <-- standard Bazel constraint, SHOULD NOT BE used!
        "@rules_go//go/toolchain:riscv64",
        "@rules_go//go/toolchain:cgo_on",
    ],
    toolchain = ":rv64_linux_toolchain",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)
