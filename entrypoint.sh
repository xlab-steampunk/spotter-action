#!/bin/sh

# set CLI arguments
endpoint="$1"
api_token="$2"
username="$3"
password="$4"
config="$5"
paths="$6"
project_id="$7"
include_values="$8"
include_metadata="$9"
display_level="${10}"
no_docs_url="${11}"
ansible_version="${12}"
profile="${13}"
skip_checks="${14}"
enforce_checks="${15}"
custom_policies_path="${16}"
custom_policies_clear="${17}"

# build global Spotter CLI command
global_spotter_command="spotter"
if [ -n "$endpoint" ]; then
  global_spotter_command="${global_spotter_command} --endpoint ${endpoint}"
fi

if [ -n "$api_token" ]; then
  global_spotter_command="${global_spotter_command} --api-token ${api_token}"
fi

if [ -n "$username" ]; then
  global_spotter_command="${global_spotter_command} --username ${username}"
fi

if [ -n "$password" ]; then
  global_spotter_command="${global_spotter_command} --password ${password}"
fi

# helper functions for building CLI subcommands
buildSetPoliciesCommand() {
  set_policies_command="${global_spotter_command} set-policies"

  if [ -n "$project_id" ]; then
    set_policies_command="${set_policies_command} --project-id ${project_id}"
  fi

  if [ -n "$custom_policies_path" ]; then
    set_policies_command="${set_policies_command} $custom_policies_path"
  fi
}

buildClearPoliciesCommand() {
  clear_policies_command="${global_spotter_command} clear-policies"

  if [ -n "$project_id" ]; then
    clear_policies_command="${clear_policies_command} --project-id ${project_id}"
  fi
}

buildScanCLICommand() {
  scan_command="${global_spotter_command} scan"

  if [ "$config" = "true" ]; then
    scan_command="${scan_command} --config ${config}"
  fi

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

  if [ -n "$skip_checks" ]; then
    skip_checks=$(printf "%s" "$skip_checks" | tr "\n" ",")
    set -- "${scan_command}" "--skip-checks" "\"""${skip_checks}""\""
    scan_command="$*"
  fi

  if [ -n "$enforce_checks" ]; then
    enforce_checks=$(printf "%s" "$enforce_checks" | tr "\n" ",")
    set -- "${scan_command}" "--enforce-checks" "\"""${enforce_checks}""\""
    scan_command="$*"
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
