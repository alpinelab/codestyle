# HTTP API development guidelines

## API description

We use [OpenAPI Specification 2.0](https://swagger.io/specification/v2/)
to describe our API.

This OAS 2.0 description is then used by:
* [Dredd](https://github.com/apiaryio/dredd) to check our implementation
* [Committee](https://github.com/interagent/committee) to validate input data
* [SwaggerUI](https://swagger.io/tools/swagger-ui) to generate documentation

## JSON generation

We use [jBuilder](https://github.com/rails/jbuilder) to write our JSON views.

We may use [Oj](https://github.com/ohler55/oj) to parse and marshall
JSON on performance-demanding projects (`jBuilder` uses
[MultiJSON](https://github.com/intridea/multi_json) that uses `Oj` as soon as
it is required, so we simply have to add it to the project `Gemfile`).

## Controllers segregation

We try to avoid processing JSON and HTML requests in the same controllers
(as Rails does by default using `respond_to` and `format.{html,json}`).

Instead, we favour an approach where API controllers are namespaced in a module
named `API` (_e.g._ `ResourcesController` processes HTML requests while
`API::ResourcesController` processes JSON requests).

It avoids unreadable controller actions with many `respond_to` and `format`,
but is a bit less [DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself)
because we basically need 2 controllers per resource.
This should incentivise us to keep business logic separated in external modules
like service classes, thus enforcing the
[SRP](https://en.wikipedia.org/wiki/Single_responsibility_principle).
