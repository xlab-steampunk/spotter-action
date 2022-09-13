#!/bin/bash

# set CLI arguments
cli_version="$1"
paths="$2"
spotter_username="$3"
spotter_password="$4"
parse_values="$5"
display_level="$6"
ansible_version="$7"

installDifferentSpotterCLIVersionIfNeeded() {
  if [ ! -z "$cli_version" ]; then
    pip install --upgrade steampunk-spotter=="${cli_version}"
  fi
}

buildMainCLICommand() {
  main_command="spotter"

  if [ ! -z "$spotter_username" ]; then
    main_command="${main_command} --username ${spotter_username}"
  fi

  if [ ! -z "$spotter_password" ]; then
    main_command="${main_command} --password ${spotter_password}"
  fi
}

buildScanCLISubCommand() {
  scan_command="scan"

  if [ ! -z "$parse_values" ]; then
    scan_command="${scan_command} --parse-values"
  fi

  if [ ! -z "$display_level" ]; then
    scan_command="${scan_command} --display-level ${display_level}"
  fi

  if [ ! -z "$ansible_version" ]; then
    scan_command="${scan_command} --option ansible_version=${ansible_version}"
  fi

  if [ ! -z "$paths" ]; then
    scan_command="${scan_command} $paths"
  else
    scan_command="${scan_command} ."
  fi
}

# install different CLI if version is specified
installDifferentSpotterCLIVersionIfNeeded

# construct the CLI command
buildMainCLICommand
buildScanCLISubCommand

# run the CLI command
${main_command} ${scan_command}
