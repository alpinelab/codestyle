# AlpineLab code style

Code style used by AlpineLab in all our projects.

## Usage

1. Add `rubocop` gems to your `Gemfile` (or `gems.rb`, or `gems.deps.rb`):

    ```ruby
    group :development, :test do
      gem "rubocop", "~> x.y", require: false
      gem "rubocop-md", "~> x.y", require: false
    end
    ```

    or install them manually:

    ```shell
    gem install rubocop rubocop-md
    ```

2. Add `alpinelab-codestyle` gem to your `Gemfile`
(or `gems.rb`, or `gems.deps.rb`):

    ```ruby
    group :development, :test do
      gem "alpinelab-codestyle", "~> x.y"
    end
    ```

    or install it manually:

    ```shell
    gem install alpinelab-codestyle
    ```

3. Create or prepend your Rubocop configuration (usually `.rubocop.yml`) with:

    ```yaml
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
