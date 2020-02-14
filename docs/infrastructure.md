# Infrastructure

## Main infrastructure provider

We host our Ruby applications on Heroku PaaS to avoid any time spent or charge related to system administration.

## External services

External infrastructure services (email service providers, error trackers, log analysers, etc…) accounts should
be registered using an email address that matches the following format:

```
infrastructure-clients+{customer_name}@alpine-lab.com
```

> where `{customer_name}` is indeed the name of the customer

They all end up in the `infrastructure-clients@alpine-lab.com` mailbox which credentials are shared on BitWarden.
