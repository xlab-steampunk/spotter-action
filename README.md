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
[Steampunk Spotter] provides an Assisted Automation Writing tool that analyzes 
and offers recommendations for your Ansible Playbooks.
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
- uses: xlab-steampunk/spotter-action@master
```

### Inputs
The action accepts the following inputs:

| Name              | Required | Default | Description                                                                                                                                                                        |
|-------------------|----------|---------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `paths`           | no       | .       | List of paths to Ansible content files to be scanned. If not specified, the whole repository is scanned.                                                                           |
| `project_id`      | no       | /       | ID of an existing target project in the app, where the scan result will be stored. If not specified, the first project of the user's first organization (in the app) will be used. |
| `upload_values`   | no       | false   | Parses and uploads values from Ansible task parameters to the backend.                                                                                                             |                                
| `upload_metadata` | no       | false   | Uploads metadata (i.e., file names, line and column numbers) to the backend.                                                                                                       |                                
| `display_level`   | no       | hint    | Displays check results with specified level or greater (e.g., warning will show all warnings and errors, but suppress hints). Available options: hint, warning, error.             |
| `no_docs_url`     | no       | false   | Omits documentation URLs from the output.                                                                                                                                          |  
| `ansible_version` | no       | /       | Ansible version to use for scanning. If not specified, all Ansible versions are considered for scanning.                                                                           |

### Outputs
The action produces the following outputs:

* `output`: Scan results from scanning your Ansible content using the `spotter scan` command.

### Environment variables
The action will take into account the following environment variables:

* `SPOTTER_USERNAME`: Steampunk Spotter account username.
* `SPOTTER_USERNAME`: Steampunk Spotter account password.

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
      - uses: actions/checkout@master
      - uses: xlab-steampunk/spotter-action@master
        env:
          SPOTTER_USERNAME: ${{ secrets.SPOTTER_USERNAME }}
          SPOTTER_PASSWORD: ${{ secrets.SPOTTER_PASSWORD }}
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
        uses: actions/checkout@master

      - name: Scan Ansible content with different inputs
        uses: xlab-steampunk/spotter-action@master
        with:
          paths: playbook.yaml
          upload_values: true
          upload_metadata: true
          display_level: error
          no_docs_url: true
          ansible_version: 2.13
        env:
          SPOTTER_USERNAME: ${{ secrets.SPOTTER_USERNAME }}
          SPOTTER_PASSWORD: ${{ secrets.SPOTTER_PASSWORD }}
```

## Acknowledgement
This tool was created by [XLAB Steampunk], IT automation specialist and 
leading expert in building Enterprise Ansible Collections.

[Steampunk Spotter]: https://steampunk.si/spotter/
[steampunk-spotter]: https://pypi.org/project/steampunk-spotter/
[new Steampunk Spotter account]: https://spotter.steampunk.si
[XLAB Steampunk]: https://steampunk.si/
