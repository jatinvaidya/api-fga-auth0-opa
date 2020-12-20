# Auth0 & Open Policy Agent (OPA) for Fine Grained API Authorization

## Motivation

- Real world authorization policies and the associated metadata required to arrive at an authorization decision can be complex and extremely varied (snowflake) from org to org.
- `Auth0` can help with API authorization via a combination of `Rules`, `Roles` & `Permissions`. This can be called as `Coarse Grained Authorization (CGA)`.
- However, when policies are/can become fine grained, it is advisable to externalize `Fine Grained Authorization (FGA)` to an org-wide centralized service for cleaner design, flexibility, scalability, CI/CD, and overall better management.
- `OPA` can be the building block for such a service (FGAaaS) by serving as a centralized general purpose `Policy Decision Point`.
- This repository covers a *sample application* to demonstrate this pattern for a `Multi-tenant API`.

## Solution Flow

1. Client app acquires an `Auth0` issued `access_token` on behalf of the authenticated `user`
   - The standard *Authorization Code Flow* can be used here.
     - This flow is not relevant to the **authorization logic or decision** and hence isn't covered here.
   - The `access_token` can be decorated with custom claims using `Auth0 Rules`.
     - The only custom claim in use in this solution is `http://example.com/authn_loa` which indicates the `Level of Assurance` of the Authentication mechanism used while authenticating the user.

2. Client app makes an API call with the `access_token`.
   - `HTTP-METHOD` /api/v1/`:tenant`/`:resource`
   - e.g. `GET /api/v1/cocacola/content_route`
   - Authorization: Bearer `access_token`

3. API code then requests OPA for an Authorization Decision
   - Here we can either use a middleware like [this](https://github.com/open-policy-agent/contrib/tree/master/spring_authz) for `Spring` or [this](https://github.com/build-security/opa-express-middleware) for `Node`. This repo uses the one for Node.
   - The middleware auto prepares `input` JSON which includes relevant request context.
   - It then makes a call to OPA for want of an authorization decision.

4. OPA computes the authorization decision
    - OPA decodes the `access_token` and extracts `user_id` and `authn_loa` from the `sub` and `http://example.com/authn_loa` claims respectively.
    - Using all the info OPA then computes the authorization decision and responds to the API.

5. API honours the decision and allows/denies the request.
