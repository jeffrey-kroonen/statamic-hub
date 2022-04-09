# Statamic hub

A [Statamic CMS](https://statamic.com/) template project

## About the project

To make it easier for starting a new Statamic project, we've created an automation tool to roll a new Statamic project out form scratch. You are ready to dive into development when you've run the tool.

## Getting Started

These instructions will get you a copy of the project and running on your local machine for development.

### Prerequisites

[Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/) must be installed on your machine.

### Installation

1. Run the initialization script from the root of the project

```shell
/bin/bash ./bin/initialize.sh
```
2. Add the local domain to your host file on your local machine

___Note:___ _Replace "PROJECT_NAME" with the name you have given in the initialization script_

```shell
# Docker development - Start
127.0.0.1 cms.PROJECT_NAME.local
::1 cms.PROJECT_NAME.local
# Docker development - End
```
## Contact

Project Link: https://github.com/jeffrey-kroonen/statamic-hub

## Acknowledgments

- [Statamic](https://statamic.com/)
- [Laravel](https://laravel.com/)
