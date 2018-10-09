# Rails-specific best practices

## Application configuration

Application configuration should **depend on environment variables**,
and absolutely **not rely on `RAILS_ENV`** value (nor `Rails.env`),
respecting the [12-factor app methodology][12-factor config].

Specifically, the following rules should be followed:

* Avoid modifying `config/environments/*.rb`: keep default Rails configuration
  in there untouched (this will also make Rails upgrades a lot smoother)
* Write application configuration in `config/application.rb`
* Avoid testing any of:
  * `ENV["RACK_ENV"]`
  * `ENV["RAILS_ENV"]`
  * `Rails.env.development?`
  * `Rails.env.production?`
  * `Rails.env.test?`

Examples:

``` ruby
# bad:
module MyRailsApp
  class Application < Rails::Application
    if Rails.env.production?
      config.middleware.use Rack::Attack
    end
  end
end

# good:
module MyRailsApp
  class Application < Rails::Application
    if ENV.key? "RACK_ATTACK_ENABLED"
      config.middleware.use Rack::Attack
    end
  end
end
```

## Routing

### Format segregation

Actual format segregation should be performed **based on the HTTP `Accept` header**
(`Accept: application/json`), *not* based on a URL suffix (`/resource.json`).

A unique resource should only be requested on a unique URL, which is why we
should **avoid extension-based routing** as much as possible.

```
# bad
GET /resources.html
GET /resources.json

# bad
GET /resources       [Accept: text/html]
GET /api/resources   [Accept: application/json]

# good
GET /resources       [Accept: text/html]
GET /resources       [Accept: application/json]
```

This can be achieved in Rails using the following router configuration:

```ruby
Rails.application.routes.draw do
  concern :resources do
    resources :posts
    resources :comments
  end

  scope format: ENV.key?("ALLOW_FORMAT_FROM_URL") ? nil : false do
    scope module: :api, constraints: ->(req) { req.format == :json } do
      concerns :resources
    end
    concerns :resources
  end
end
```

[12-factor config]: https://12factor.net/config
