# AlpineLab code style

Code style used by AlpineLab in all our projects.

## Usage

1. Add this gem to your `Gemfile` (or `gems.rb`, or `gems.deps.rb`):

    ```ruby
    group :development do
      gem "alpinelab-codestyle", "~> x.y"
    end
    ```

    or install it manually:

    ```shell
    gem install alpinelab-codestyle
    ```

2. Create or prepend your Rubocop configuration (usually `.rubocop.yml`) with:

    ```yaml
    inherit_gem:
      alpinelab-codestyle:
        - config/default.yml
    ```

## License

This project is developed by [Alpine Lab](https://www.alpine-lab.com) and released under the terms of the [MIT license](LICENSE.md).

<a href="https://www.alpine-lab.com"><img src=".github/alpinelab-logo.png" width="40%" /></a>

