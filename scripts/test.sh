#!/bin/sh

# Test the tests

# Shellcheck all scripts
find . -type f -name "*.sh" -exec shellcheck -x {} \;
