# AlpineLab code style

Code style used by AlpineLab in all our projects.

## Usage

### Rubocop integration

* Use this gem as a dependency, or just install it;
* Update Rubocop configuration with:
  ``` yaml
  inherit_gem:
    alpinelab-codestyle:
      - config/default.yml
  ```

## Best practices

Some conventions are adopted and enforced, in no particular order:

1. Developer-specific configuration files must be git-ignored globally, _e.g._:

    * `.ruby-{version,gemset}`
    * `docker-compose.override.yml`

2. Project-specific configuration files must be git-ignored per project, _e.g._:

    * `config/database.yml`

## License

This project is developed by [Alpine Lab](https://www.alpine-lab.com) and released under the terms of the [MIT license](LICENSE.md).

<a href="https://www.alpine-lab.com"><img src=".github/alpinelab-logo.png" width="40%" /></a>
