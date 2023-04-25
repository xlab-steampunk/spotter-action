#!/bin/sh

# set CLI arguments
paths="$1"
project_id="$2"
include_values="$3"
include_metadata="$4"
display_level="$5"
no_docs_url="$6"
ansible_version="$7"
profile="$8"

buildScanCLICommand() {
  scan_command="spotter scan"

  if [ "$project_id" = "true" ]; then
    scan_command="${scan_command} --project-id ${project_id}"
  fi

  if [ "$include_values" = "true" ]; then
    scan_command="${scan_command} --include-values"
  fi

  if [ "$include_metadata" = "true" ]; then
    scan_command="${scan_command} --include-metadata"
  fi

  if [ -n "$display_level" ]; then
    scan_command="${scan_command} --display-level ${display_level}"
  fi

  if [ "$no_docs_url" = "true" ]; then
    scan_command="${scan_command} --no-docs-url"
  fi

  if [ -n "$ansible_version" ]; then
    scan_command="${scan_command} --ansible-version ${ansible_version}"
  fi

  if [ -n "$profile" ]; then
    scan_command="${scan_command} --profile ${profile}"
  fi

  if [ -n "$paths" ]; then
    scan_command="${scan_command} $paths"
  fi
}

# construct the CLI command
buildScanCLICommand

# run the CLI command
${scan_command}
