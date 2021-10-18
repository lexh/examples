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
            path = "/Users/lherbert/Downloads/clang+llvm-12.0.0-x86_64-apple-darwin/bin/clang",
        ),
        tool_path(
            name = "ld",
            path = "/Users/lherbert/Downloads/clang+llvm-12.0.0-x86_64-apple-darwin/bin/ld",
        ),
        tool_path(
            name = "ar",
            path = "/Users/lherbert/Downloads/clang+llvm-12.0.0-x86_64-apple-darwin/bin/ar",
        ),
        tool_path(
            name = "cpp",
            path = "/Users/lherbert/Downloads/clang+llvm-12.0.0-x86_64-apple-darwin/bin/cpp",
        ),
        tool_path(
            name = "gcov",
            path = "/Users/lherbert/Downloads/clang+llvm-12.0.0-x86_64-apple-darwin/bin/gcov",
        ),
        tool_path(
            name = "nm",
            path = "/Users/lherbert/Downloads/clang+llvm-12.0.0-x86_64-apple-darwin/bin/nm",
        ),
        tool_path(
            name = "objdump",
            path = "/Users/lherbert/Downloads/clang+llvm-12.0.0-x86_64-apple-darwin/bin/objdump",
        ),
        tool_path(
            name = "strip",
            path = "/Users/lherbert/Downloads/clang+llvm-12.0.0-x86_64-apple-darwin/bin/strip",
        ),
    ]
    features = [
        feature(
            name = "default_linker_flags",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = all_link_actions,
                    flag_groups = ([
                        flag_group(
                            flags = [
                                "-libstdc++",
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
            "/Users/lherbert/Downloads/clang+llvm-12.0.0-x86_64-apple-darwin/include",
            "/Users/lherbert/Downloads/clang+llvm-12.0.0-x86_64-apple-darwin/lib",
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


