#!/bin/sh

# set CLI arguments
paths="$1"
project_id="$2"
upload_values="$3"
upload_metadata="$4"
display_level="$5"
ansible_version="$6"

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

# construct the CLI command
buildScanCLICommand

# run the CLI command
${scan_command}
