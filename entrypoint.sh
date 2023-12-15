#!/bin/sh

# set CLI arguments
endpoint="$1"
api_token="$2"
username="$3"
password="$4"
timeout="$5"
config="$6"
paths="$7"
project_id="$8"
exclude_values="$9"
exclude_metadata="${10}"
display_level="${11}"
no_docs_url="${12}"
ansible_version="${13}"
profile="${14}"
skip_checks="${15}"
enforce_checks="${16}"
custom_policies_path="${17}"
custom_policies_clear="${18}"

# build global Spotter CLI command
global_spotter_command="spotter --no-color"
if [ -n "$endpoint" ]; then
  global_spotter_command="${global_spotter_command} --endpoint ${endpoint}"
fi

if [ -n "$api_token" ]; then
  global_spotter_command="${global_spotter_command} --token ${api_token}"
fi

if [ -n "$username" ]; then
  global_spotter_command="${global_spotter_command} --username ${username}"
fi

if [ -n "$password" ]; then
  global_spotter_command="${global_spotter_command} --password ${password}"
fi

if [ -n "$timeout" ]; then
  global_spotter_command="${global_spotter_command} --timeout ${timeout}"
fi

# helper functions for building CLI subcommands
buildPoliciesCommand() {
  policies_command="${global_spotter_command} policies"

  if [ -n "$project_id" ]; then
    policies_command="${policies_command} --project-id ${project_id}"
  fi
}

buildPoliciesSetCommand() {
  buildPoliciesCommand
  policies_set_command="${policies_command} set"

  if [ -n "$custom_policies_path" ]; then
    policies_set_command="${policies_set_command} $custom_policies_path"
  fi
}

buildPoliciesClearCommand() {
  buildPoliciesCommand
  policies_clear_command="${policies_command} clear"
}

buildScanCLICommand() {
  scan_command="${global_spotter_command} scan --origin ci --no-progress"

  if [ "$config" = "true" ]; then
    scan_command="${scan_command} --config ${config}"
  fi

  if [ "$project_id" = "true" ]; then
    scan_command="${scan_command} --project-id ${project_id}"
  fi

  if [ "$exclude_values" = "true" ]; then
    scan_command="${scan_command} --exclude-values"
  fi

  if [ "$exclude_metadata" = "true" ]; then
    scan_command="${scan_command} --exclude-metadata"
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
buildPoliciesSetCommand
buildScanCLICommand
buildPoliciesClearCommand

# run CLI commands
if [ -n "$custom_policies_path" ]; then
  ${policies_set_command}
  ${scan_command}
  if [ "$custom_policies_clear" = "true" ]; then
    ${policies_clear_command}
  fi
else
  ${scan_command}
fi
