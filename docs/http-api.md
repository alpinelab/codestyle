# HTTP API development guidelines

## API description

We use [OpenAPI Specification 2.0] to describe our API.

This OAS 2.0 description is then used by:
* [Dredd] to check our implementation
* [Committee] to validate input data
* [SwaggerUI] to generate documentation

## JSON generation

We use [jBuilder] to write our JSON views.

We may use [Oj] to parse and marshall JSON on performance-demanding projects
([jBuilder] uses [MultiJSON] that uses [Oj] as soon as it is required,
so we simply have to add it to the project `Gemfile`).

## Controllers segregation

We try to avoid processing JSON and HTML requests in the same controllers
(as Rails does by default using `respond_to` and `format.{html,json}`).

Instead, we favour an approach where API controllers are namespaced in a module
named `API` (_e.g._ `ResourcesController` processes HTML requests while
`API::ResourcesController` processes JSON requests).

It avoids unreadable controller actions with many calls to `respond_to` and
`format`, but is a bit less [Don't Repeat Yourself] because we basically need
two controllers per resource. On the other hand, it incentivises us to keep
business logic separated in external modules like service classes,
thus enforcing the [Single Responsibility Principle].

[Committee]: https://github.com/interagent/committee
[Don't Repeat Yourself]: https://en.wikipedia.org/wiki/Don%27t_repeat_yourself
[Dredd]: https://github.com/apiaryio/dredd
[jBuilder]: https://github.com/rails/jbuilder
[MultiJSON][https://github.com/intridea/multi_json]
[Oj]: https://github.com/ohler55/oj
[OpenAPI Specification 2.0]: https://swagger.io/specification/v2/
[Single Responsibility Principle]: https://en.wikipedia.org/wiki/Single_responsibility_principle
[SwaggeUI]: https://swagger.io/tools/swagger-ui
