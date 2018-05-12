#!/usr/bin/env bash

# Determine if we are in a subshell or being sourced
if [[ "$0" == "${BASH_SOURCE}" ]]; then
  echo "This script is intended to configure the build environment."
  echo "It should be sourced, rather than run in a subshell."
  exit 1
fi

pushd $(dirname $BASH_SOURCE) &>/dev/null
MY_DIR=$(pwd -P)
popd &>/dev/null

ANT_VERSION="apache-ant-1.9.11"
ANT_PATH="${MY_DIR}/${ANT_VERSION}/bin"
TOOLS_PATH="${MY_DIR}/tools/bin"

echo "INFO: Extracting $ANT_VERSION"
unzip -u ${ANT_VERSION}*.zip > /dev/null

[[ $PATH =~ $ANT_PATH ]] || PATH="${ANT_PATH}:${PATH}"
[[ $PATH =~ $TOOLS_PATH ]] || PATH="${TOOLS_PATH}:${PATH}"

export PATH
echo "INFO: PATH set to $PATH"

[[ -z $JAVA_HOME ]] && echo "ERROR: JAVA_HOME not set"
which ant &>/dev/null || echo "ERROR: ant not found in PATH"
[[ -e $JAVA_HOME/bin/java ]] || echo "ERROR: Could not find $JAVA_HOME/bin/java"

echo "INFO: Setup Complete. If there were any errors, you should correct them before proceeding."
