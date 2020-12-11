# Auth0 & Open Policy Agent (OPA) for Fine Grained API Authorization

- Authorization policies and the metadata required to arrive at a decision are both complex and extremely varied from org to org.
- Auth0 can help with API authorization via a combination of Rules, Roles & Permissions. This can be called as Coarse Grained Authorization (CGA).
- However, when policies are/can become fine grained, it is advisable to externalize Fine Grained Authorization (FGA) to an org-wide common service for cleaner design, scalability, CI/CD, and overall better management.
- OPA can be the building block for such a service (FGAaaS)
- This Repository covers a sample application to demonstrate this pattern.

## Sample Authorization Policy Rules

- `Deny` by default
- `Allow` scenarios are as follows:

| Role on Tenant | Action | Tenanted Resource|Authn LOA|
|--------|:------:|-------|----|
|admin|delete|tenant|2 (strong)|
|admin|create|upload_token|1 (default)|
|admin|index|content_route|1 (default)|
|admin|index|vpc|1 (default)|
|admin|validate|upload_token|1 (default)|
|admin|create|certificate_metadata|1 (default)|
|poweruser|index|content_route|1 (default)|
|poweruser|index|vpc|1 (default)|
|poweruser|validate|upload_token|1 (default)|
|user|validate|upload_token|1 (default)|

_Note: For example, the first one reads like:_

>_A user with role `admin` on a particular `tenant` CAN `create` an `upload_token` on that `tenant`._

## Sample Authorization Data

|User ID|Tenant|Role|
|----|-----|------|
|auth0:5cc8e4336847810e751aa8ce|cocacola|admin|
|auth0:5cc8e4336847810e751aa8ce|abercrombie|poweruser|
|auth0:5cc8e4336847810e751aa8ce|adidas|user|
|auth0:5cc8e4336847810e751aa8ce|chevrolet|admin|
|auth0:5e716d7148de9f0ca1257252|adidas|admin|
|auth0:5e716d7148de9f0ca1257252|chevrolet|user|

## Authorization Input

OPA `input`

|Field|Source|
|----|----|
|user_id|API access_token|
|authn_loa|API access_token|
|action|API request METHOD|
|resource|API request URI|
|tenant|API request URI|

_Note: This is flexible, we can decorate the `access_token` with more claims via Auth0 Rule if/when required._

## Solution Flow

1. Client app acquires an `access_token` on behalf of the `user`
   - The standard *Authorization Code Flow* can be used here.
     - This flow is not relevant to the **authorization logic or decision** and hence isn't covered here.
   - The `access_token` can be decorated with custom claims using Auth0 Rules.
     - The only custom claim in use in this solution is `http://example.com/loa` which indicates the *Level of Assurance* of the Authentication mechanism used while authenticating the user.

2. Client app makes an API call with the `access_token`.
   - {METHOD} /api/v1/{tenant}/{resource}
   - e.g. GET /api/v1/cocacola/content_route
   - Authorization: Bearer {access_token}

3. API code then prepares to call OPA for an Authorization Decision 
   - extracts `tenant` & `resource` from the request URI
   - maps HTTP method of the request to `action`
   - includes the AT as is in the request
   - makes a call to OPA to get a decision

4. OPA computes the authorization decision
    - OPA decodes the `access_token` and extracts `user_id` and `loa` from the `sub` and `http://example.com/loa` claims respectively.
    - using all the 5 pieces of info OPA then computes the authorization decision and responds to the API

5. API honours the decision and allows/denies the request.

# Local Unit Test of the OPA Policy
1. Clone this repository and cd to it.
2. Install the OPA binary locally
3. `data.json` has already been populated with some sample data (edit it if/as required).
4. `opa test -v .`