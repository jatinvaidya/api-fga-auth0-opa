# OPA Config

## Sample Authorization Policy Rules

- `Deny` by default
- `Allow` scenarios are as follows:

| Role on Tenant | Action | Resource on Tenant|Authn LOA|
|--------|:------:|-------|----|
|admin|DELETE|any|2 (strong)|
|admin|POST|any|1 (default)|
|admin|GET|any|1 (default)|
|poweruser|POST|content_route, vpc|1 (default)|
|poweruser|GET|any|1 (default)|
|user|GET|upload_token|1 (default)|

_Note: For example, the first one reads like:_

>_A user with role `admin` on a particular `tenant` CAN `create` an `upload_token` on that `tenant`._

## Sample Authorization Data
_Note: see `data.json`_

|User ID|Tenant|Role|
|----|-----|------|
|auth0:5cc8e4336847810e751aa8ce|cocacola|admin|
|auth0:5cc8e4336847810e751aa8ce|abercrombie|poweruser|
|auth0:5cc8e4336847810e751aa8ce|adidas|user|
|auth0:5cc8e4336847810e751aa8ce|chevrolet|admin|
|auth0:5e716d7148de9f0ca1257252|adidas|admin|
|auth0:5e716d7148de9f0ca1257252|chevrolet|user|

## Authorization Input
_Note: see `input.json`_

OPA `input`

|Field|Source|
|----|----|
|user_id|API access_token|
|authn_loa|API access_token|
|action|API request METHOD|
|resource|API request URI|
|tenant|API request URI|

_Note: This is flexible, we can decorate the `access_token` with more claims via Auth0 Rule if/when required._

# Local Unit Test of the OPA Policy

1. Clone this repository and cd to it.
2. Install the OPA binary locally
3. [data.json](data.json) has already been populated with some sample data (edit it if/as required).
4. [input.json](input.json) has already been populated with some sample input (edit it if/as required).
5. cd `api-fga-auth0-opa/opa`
6. `opa test -v .`