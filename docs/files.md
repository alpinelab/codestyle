# File structure and organization

1. Developer-specific configuration files must be git-ignored globally, _e.g._:

    * `.ruby-{version,gemset}`
    * `docker-compose.override.yml`

2. Project-specific configuration files must be git-ignored per project, _e.g._:

    * `config/database.yml`
