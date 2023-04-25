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
custom_policies_path="$9"
custom_policies_clear="${10}"

# helper functions for building CLI commands
buildSetPoliciesCommand() {
  set_policies_command="spotter set-policies"

  if [ -n "$project_id" ]; then
    set_policies_command="${set_policies_command} --project-id ${project_id}"
  fi

  if [ -n "$custom_policies_path" ]; then
    set_policies_command="${set_policies_command} $custom_policies_path"
  fi
}

buildClearPoliciesCommand() {
  clear_policies_command="spotter clear-policies"

  if [ -n "$project_id" ]; then
    clear_policies_command="${clear_policies_command} --project-id ${project_id}"
  fi
}

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

# construct CLI commands
buildSetPoliciesCommand
buildScanCLICommand
buildClearPoliciesCommand

# run CLI commands
if [ -n "$custom_policies_path" ]; then
  ${set_policies_command}
  ${scan_command}
  if [ "$custom_policies_clear" = "true" ]; then
    ${clear_policies_command}
  fi
else
  ${scan_command}
fi
