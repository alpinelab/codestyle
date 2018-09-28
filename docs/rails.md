# Rails conventions

## App behavior should be configured via environment variables

When implementing new features, it should not depend on current
`RAILS_ENV` value, but environment variable(s) specific to the
feature.

* Avoid modifying `config/environments/*.rb`, and keep default
  Rails configuration (this will also help when updating Rails)
* Avoid testing:
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
