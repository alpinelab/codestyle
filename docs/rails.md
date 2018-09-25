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
