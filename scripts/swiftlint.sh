#!/bin/sh

# for Apple silicon macs
export PATH="/opt/homebrew/bin/:$PATH"

# Run SwiftLint
bazel run -c opt @SwiftLint//:swiftlint

