load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "feature",
    "flag_group",
    "flag_set",
    "tool_path",
)

all_link_actions = [
    ACTION_NAMES.cpp_link_executable,
    ACTION_NAMES.cpp_link_dynamic_library,
    ACTION_NAMES.cpp_link_nodeps_dynamic_library,
]

def _impl(ctx):
    tool_paths = [
        tool_path(
            name = "gcc",
            path = "/home/lex/clang+llvm-11.0.1-x86_64-linux-gnu-ubuntu-20.10/bin/clang",
        ),
        tool_path(
            name = "ld",
            path = "/home/lex/clang+llvm-11.0.1-x86_64-linux-gnu-ubuntu-20.10/bin/lld",
        ),
        tool_path(
            name = "ar",
            path = "/home/lex/clang+llvm-11.0.1-x86_64-linux-gnu-ubuntu-20.10/bin/llvm-ar",
        ),
        tool_path(
            name = "cpp",
            path = "/home/lex/clang+llvm-11.0.1-x86_64-linux-gnu-ubuntu-20.10/bin/clang-cpp",
        ),
        tool_path(
            name = "gcov",
            path = "/home/lex/clang+llvm-11.0.1-x86_64-linux-gnu-ubuntu-20.10/bin/llvm-cov",
        ),
        tool_path(
            name = "nm",
            path = "/home/lex/clang+llvm-11.0.1-x86_64-linux-gnu-ubuntu-20.10/bin/llvm-nm",
        ),
        tool_path(
            name = "objdump",
            path = "/home/lex/clang+llvm-11.0.1-x86_64-linux-gnu-ubuntu-20.10/bin/llvm-objdump",
        ),
        tool_path(
            name = "strip",
            path = "/home/lex/clang+llvm-11.0.1-x86_64-linux-gnu-ubuntu-20.10/bin/llvm-strip",
        ),
    ]
    features = [
        # NEW
        feature(
            name = "default_linker_flags",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = all_link_actions,
                    flag_groups = ([
                        flag_group(
                            flags = [
                                "-lstdc++",
                            ],
                        ),
                    ]),
                ),
            ],
        ),
    ]
    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        features = features,
        cxx_builtin_include_directories = [
            "/home/lex/clang+llvm-11.0.1-x86_64-linux-gnu-ubuntu-20.10/include/c++/v1",
            "/home/lex/clang+llvm-11.0.1-x86_64-linux-gnu-ubuntu-20.10/lib/clang/11.0.1/include",
            "/usr/include"
        ],
        toolchain_identifier = "darwin-toolchain",
        host_system_name = "local",
        target_system_name = "local",
        target_cpu = "darwin",
        target_libc = "unknown",
        compiler = "clang",
        abi_version = "unknown",
        abi_libc_version = "unknown",
        tool_paths = tool_paths,
    )

cc_toolchain_config = rule(
    implementation = _impl,
    attrs = {},
    provides = [CcToolchainConfigInfo],
)


