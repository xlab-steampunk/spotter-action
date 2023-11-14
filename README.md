# GitHub Action for Steampunk Spotter
A GitHub Action for scanning your Ansible content with [Steampunk Spotter].

## Table of Contents
- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
  - [Inputs](#inputs)
  - [Outputs](#outputs)
  - [Environment variables](#environment-variables)
- [Acknowledgement](#acknowledgement)

## Introduction
[Steampunk Spotter] is an Ansible Playbook Platform that scans, analyzes,
enhances, and provides insights for your playbooks.

This GitHub Action allows you to use [steampunk-spotter] CLI within GitHub
CI/CD workflows.

## Prerequisites
You will need to create a [new Steampunk Spotter account] to be able to use
this action.

## Usage
To integrate [Steampunk Spotter] with your GitHub CI/CD pipeline, you have to
specify the name of this repository with a tag number as a step within your
YAML workflow file.

For example, inside your `.github/workflows/ci.yml` file:

```yaml
steps:
- uses: actions/checkout@master
- uses: xlab-steampunk/spotter-action@<version>
```

### Inputs
The action accepts the following inputs:

| Name                    | Required | Default | Description                                                                                                                                                                        |
|-------------------------|----------|---------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `endpoint`              | no       | /       | Steampunk Spotter API endpoint (instead of default https://api.spotter.steampunk.si/api).                                                                                          |
| `api_token`             | no       | /       | Steampunk Spotter API token (can be generated in the user settings within the Spotter App).                                                                                        |
| `username`              | no       | /       | Steampunk Spotter username (this is an old auth method, use API token if possible).                                                                                                |
| `password`              | no       | /       | Steampunk Spotter password (this is an old auth method, use API token if possible).                                                                                                |
| `config`                | no       | /       | Path to JSON/YAML configuration file.                                                                                                                                              |
| `paths`                 | no       | .       | List of paths to Ansible content files to be scanned. If not specified, the whole repository is scanned.                                                                           |
| `project_id`            | no       | /       | ID of an existing target project in the app, where the scan result will be stored. If not specified, the first project of the user's first organization (in the app) will be used. |
| `exclude_values`        | no       | false   | Omits parsing and uploading values from Ansible playbooks.                                                                                                                         |
| `exclude_metadata`      | no       | false   | Omits collecting and uploading metadata (i.e., file names, line and column numbers).                                                                                               |
| `display_level`         | no       | hint    | Displays check results with specified level or greater (e.g., warning will show all warnings and errors, but suppress hints). Available options: hint, warning, error.             |
| `no_docs_url`           | no       | false   | Omits documentation URLs from the output.                                                                                                                                          |
| `ansible_version`       | no       | /       | Ansible version to use for scanning. If not specified, all Ansible versions are considered for scanning.                                                                           |
| `profile`               | no       | /       | Sets profile with selected set of checks to be used for scanning.                                                                                                                  |
| `skip_checks`           | no       | /       | Skips checks with specified IDs. IDs should be comma-separated, space-separated or newline-separated and can be found in the check catalog within the Spotter App.                 |
| `enforce_checks`        | no       | /       | Enforce checks with specified IDs. IDs should be comma-separated, space-separated or newline-separated and can be found in the check catalog within the Spotter App.               |
| `custom_policies_path`  | no       | /       | Path to the file or folder with custom OPA policies written in Rego Language (enterprise feature).                                                                                 |
| `custom_policies_clear` | no       | /       | Clears OPA policies for custom Spotter checks after scanning (enterprise feature).                                                                                                 |

### Outputs
The action produces the following outputs:

* `output`: Scan results from scanning your Ansible content using the `spotter scan` command.

### Environment variables
The action will take into account the following environment variables:

* `SPOTTER_ENDPOINT`: Steampunk Spotter API endpoint (instead of default
  https://api.spotter.steampunk.si/api).
* `SPOTTER_API_TOKEN`: Steampunk Spotter API token (can be generated in the
   user settings within the Spotter App);
* `SPOTTER_USERNAME`: Steampunk Spotter username;
* `SPOTTER_PASSWORD`: Steampunk Spotter password.

We encourage you to authenticate by setting `SPOTTER_API_TOKEN` instead of old
`SPOTTER_USERNAME` and `SPOTTER_PASSWORD` environment variables.

### Examples
Here are some examples of how to use this GH Action.

Minimal example that scans the whole repository would look like this:

```yaml
name: Minimal CI/CD workflow for Steampunk Spotter
on: [push]
jobs:
  run:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: xlab-steampunk/spotter-action@<version>
        env:
          SPOTTER_API_TOKEN: ${{ secrets.SPOTTER_API_TOKEN }}
```

A more complex example with multiple action inputs is the following:

```yaml
name: More complex CI/CD workflow for Steampunk Spotter
on: [push]
jobs:
  run:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Scan Ansible content with different inputs
        uses: xlab-steampunk/spotter-action@<version>
        with:
          endpoint: https://api.spotter.steampunk.si/api
          api_token: ${{ secrets.SPOTTER_API_TOKEN }}
          config: config.yaml
          paths: playbook.yaml
          exclude_values: true
          exclude_metadata: true
          display_level: error
          no_docs_url: true
          ansible_version: 2.14
          profile: full
          skip_checks: E001,E903[fqcn=sensu.sensu_go.user]
          enforce_checks: E1300,E1301
```

## Acknowledgement
This GitHub Action was created by [XLAB Steampunk], IT automation specialist
and leading expert in building Enterprise Ansible Collections.

[Steampunk Spotter]: https://steampunk.si/spotter/
[steampunk-spotter]: https://pypi.org/project/steampunk-spotter/
[new Steampunk Spotter account]: https://spotter.steampunk.si
[XLAB Steampunk]: https://steampunk.si/
