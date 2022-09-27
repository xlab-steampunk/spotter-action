#!/bin/sh

# set CLI arguments
cli_version="$1"
paths="$2"
project_id="$3"
upload_values="$4"
upload_metadata="$5"
display_level="$6"
ansible_version="$7"

installDifferentSpotterCLIVersionIfNeeded() {
  if [ -n "$cli_version" ]; then
    pip install --upgrade steampunk-spotter=="${cli_version}"
  fi
}

buildScanCLICommand() {
  scan_command="spotter scan"

  if [ "$project_id" = "true" ]; then
    scan_command="${scan_command} --project-id ${project_id}"
  fi

  if [ "$upload_values" = "true" ]; then
    scan_command="${scan_command} --upload-values"
  fi

  if [ "$upload_metadata" = "true" ]; then
    scan_command="${scan_command} --upload-metadata"
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
