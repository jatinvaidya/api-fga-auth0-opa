package example

# curl --request PUT --url http://localhost:8181/v1/policies/example --data-binary @policy.rego
# curl --request PUT --url http://localhost:8181/v1/data/example --data-binary @data.json

# HTTP API request
import input.request.path

# deny by default
default allow = false

# allow user with 'admin' role to 'DELETE' a 'resource' from an entitled 'tenant'
allow {
    input.request.method == "GET"
    role_on_tenant := user_has_some_role_on_tenant
    role_has_required_perm(role_on_tenant)
}

allow {
    input.request.method == "POST"
    role_on_tenant := user_has_some_role_on_tenant
    role_has_required_perm(role_on_tenant)
}

allow {
    input.request.method == "DELETE"
    claims["http://example.com/authn_loa"] == "2"
    role_on_tenant := user_has_some_role_on_tenant
    role_has_required_perm(role_on_tenant)
}

# extract access_token
bearer_token := t {
	v := input.request.headers.authorization
	startswith(v, "Bearer ")
	t := substring(v, count("Bearer "), -1)
}

# parse access_token payload
claims := payload {
    [_, payload, _] := io.jwt.decode(bearer_token)
}

# make sure user has some role on the tenant
# return that role
user_has_some_role_on_tenant = role_on_tenant {
    parsed_path := split(input.request.path, "/")

    some input_tenant
    parsed_path = ["", "api", "v1", input_tenant, _]
    
    some i
    input_tenant == data.example.user_tenants[claims.sub][i].tenant
    role_on_tenant := data.example.user_tenants[claims.sub][i].role
}

# make sure the role that the user has on the tenant is entitled 
# to the action (http method) the user is trying to perform
role_has_required_perm(role_on_tenant) {
    data.example.role_perms["admin"][_] == input.request.method
}
