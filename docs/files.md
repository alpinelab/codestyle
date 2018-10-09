# File structure and organization

## Git-ignore'd files

**Developer-specific** configuration files should be
[git-ignored globally], _e.g._:

* `.ruby-version`
* `.ruby-gemset`
* `docker-compose.override.yml`

**Project-specific** configuration files should be
[git-ignored locally] (_i.e._ per project), _e.g._:

* `config/database.yml`

[git-ignored locally]: https://help.github.com/articles/ignoring-files/#create-a-local-gitignore
[git-ignored globally]: https://help.github.com/articles/ignoring-files/#create-a-global-gitignore
