#!/bin/bash

# set CLI arguments
cli_version="$1"
paths="$2"
parse_values="$3"
display_level="$4"
ansible_version="$5"

installDifferentSpotterCLIVersionIfNeeded() {
  if [ -n "$cli_version" ]; then
    pip install --upgrade steampunk-spotter=="${cli_version}"
  fi
}

buildScanCLICommand() {
  scan_command="spotter scan"

  if [ "$parse_values" == "true" ]; then
    scan_command="${scan_command} --parse-values"
  fi

  if [ -n "$display_level" ]; then
    scan_command="${scan_command} --display-level ${display_level}"
  fi

  if [ -n "$ansible_version" ]; then
    scan_command="${scan_command} --option ansible_version=${ansible_version}"
  fi

  if [ -n "$paths" ]; then
    scan_command="${scan_command} $paths"
  fi
}

# install different CLI if version is specified
installDifferentSpotterCLIVersionIfNeeded

# construct the CLI command
buildScanCLICommand

# run the CLI command
${scan_command}
