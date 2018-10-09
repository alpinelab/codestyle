# AlpineLab code style

Code style used by AlpineLab in all our projects.

## Usage

1. Add those gems to your `Gemfile` (or `gems.rb`, or `gems.deps.rb`):

    ```ruby
    group :development, :test do
      gem "alpinelab-codestyle", "~> x.y", require: false
      gem "rubocop", "~> x.y", require: false
      gem "rubocop-md", "~> x.y", require: false
    end
    ```

    or install them manually:

    ```shell
    gem install alpinelab-codestyle rubocop rubocop-md
    ```

2. Create or prepend your Rubocop configuration (usually `.rubocop.yml`) with:

    ```yaml
    inherit_gem:
      alpinelab-codestyle:
        - config/default.yml
        - config/rails.yml # for Rails projects only
    ```

## Best practices

Some conventions are adopted and enforced, but cannot be translated as Rubocop
rules (or are not supposed to). You will find those conventions as Markdown
files in the [`docs`](docs) directory of this project, organized by subject:

* [File structure and organisation](docs/files.md)
* [Rails-specific conventions](docs/rails.md)
* [HTTP API development guidelines](docs/http-api.md)

## Releases

To release this very gem:

1. Bump its version number in [`version.rb`] respecting [Semantic Versioning 2]

2. Use Bundler Rake task to build, tag and push the gem:

    ```shell
    rake release
    ```

    _(using Docker, both [Git authentication] and [Rubygems authentication] must
    be configured to run `docker-compose run app rake release`)_

## License

This project is developed by [Alpine Lab] and released under the terms of the
[MIT license].

<a href="https://www.alpine-lab.com">
  <img src=".github/alpinelab-logo.png" width="40%" />
</a>

[Alpine Lab]: https://www.alpine-lab.com
[git authentication]: https://github.com/alpinelab/docker-ruby-dev/blob/latest/RECIPES.md#git-authentication
[MIT license]: LICENSE.md
[RubyGems authentication]: https://github.com/alpinelab/docker-ruby-dev/blob/latest/RECIPES.md#rubygems-authentication
[Semantic Versioning 2]: https://semver.org/spec/v2.0.0.html
[`version.rb`]: lib/alpine_lab/code_style/version.rb
