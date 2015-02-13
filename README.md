# wercker-step-maven_central
[![wercker status](https://app.wercker.com/status/b9fe5c9f5efa451038a7158c25a04d52/m "wercker status")](https://app.wercker.com/project/bykey/b9fe5c9f5efa451038a7158c25a04d52)

Wercker Step for Publish to Maven Central

# Usage

## Arguments

Almost arguments are recognized from environment if project is in Github.

| Name | Required | Description |
|---|:-:|---|
| project-url | N | URL of Project to publish in POM (Auto regognized from environment) |
| license-name | N | Available for MIT,GPL,GPL2,LGPL and Apache. Non version number means newest one. (Auto regognized from LICENSE file on repository) |
| license-url | N | Auto regognized by license-name |
| scm-url | N | Publish in POM (Auto regognized from environment) |
| scm-connection | N | Publish in POM (Auto regognized from environment) |
| developer-id | N | Publish in POM (Auto regognized from environment) |
| developer-name | N | Publish in POM (Auto regognized from environment) |
| developer-url | N | Publish in POM (Auto regognized from environment) |
| repository-username | Y | Username to login to repository site |
| repository-password | Y | Password to login to repository site |
| pgp-secring | Y | Base64 of secure ring file |
| pgp-passphrase | Y | Passphrase for secring |
