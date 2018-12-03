# Monitoring

## Notifications

### Staging environments

Staging environments are configured to send monitoring alerts to
`{project}-staging@alpine-lab.com`.

This email address is configured in GSuite as a group, to which any developer
can subscribe.

They should also be configured to report monitoring alerts to the project
dedicated Slack channel.

### Production environments

Production environments are configured to send monitoring alerts to
`production-notifications+{project}@alpine-lab.com`.

This email address is automatically delivered by GMail to
`production-notifications@alpine-lab.com` which is an alias for
`devs@alpine-lab.com`, to which **all** developers are subscribed.

They should also be configured to report monitoring alerts to the project
dedicated Slack channel.
