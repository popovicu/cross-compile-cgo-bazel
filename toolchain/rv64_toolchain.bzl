load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl", "feature", "tool_path", "flag_group", "flag_set")
load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")

def _impl(ctx):
    toolchain_tools = ["gcc", "ld", "ar", "cpp", "gcov", "nm", "objdump", "strip"]
    tool_paths = [tool_path(name = tool, path = "/home/uros/build/rv64_toolchain_linux/bin/riscv64-unknown-linux-gnu-{}".format(tool)) for tool in toolchain_tools]

    ASSEMBLE_ACTIONS = [
        ACTION_NAMES.assemble,
        ACTION_NAMES.preprocess_assemble,
    ]
    
    COMPILE_ACTIONS = [
        ACTION_NAMES.cpp_compile,
        ACTION_NAMES.c_compile
    ]
    
    ASSEMBLE_AND_COMPILE_ACTIONS = ASSEMBLE_ACTIONS + COMPILE_ACTIONS

    LINK_ACTIONS = [
        ACTION_NAMES.cpp_link_executable,
    ]

    no_build_id = feature(
        name = "no_build_id",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = LINK_ACTIONS,
                flag_groups = [
                    flag_group(
                        flags = ["-Wl,--build-id=none"],
                    ),
                ],
            )
        ],
    )
    
    features = [no_build_id]
    
    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        toolchain_identifier = "riscv64-linux-gnu",
        host_system_name = "local",
        target_system_name = "local",
        target_cpu = "riscv64",
        target_libc = "glibc",
        compiler = "gcc",
        abi_version = "unknown",
        abi_libc_version = "unknown",
        tool_paths = tool_paths,
        cxx_builtin_include_directories = [
            # "/usr/riscv64-linux-gnu/include/",
            "/home/uros/build/rv64_toolchain_linux/sysroot/usr/include/",
            # "/usr/lib/gcc-cross/riscv64-linux-gnu/10/include/",
            "/home/uros/build/rv64_toolchain_linux/lib/gcc/riscv64-unknown-linux-gnu/15.1.0/include/"
        ],
        features = features,
    )

rv64_linux_toolchain_config = rule(
    implementation = _impl,
    attrs = {},
    provides = [CcToolchainConfigInfo],
)
