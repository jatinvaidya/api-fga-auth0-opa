package com.example.fga.demo

#HTTP API request
import input

#deny by default
default allow = false

#allow rules

###### allow user with 'admin' role to...######

###...'DELETE' an entitled 'tenant'
allow {
    is_delete_method
    is_user_entitled_to_tenant
    some i
    data.user_tenants[claims.sub][i].role == "admin"
}

is_get_method {
    input.request.method == "GET"
}

is_post_method {
    input.request.method == "POST"
}

is_delete_method {
    input.request.method == "DELETE"
}

is_user_entitled_to_tenant {
    some tenant
    input.path = ["api", "v1", tenant]

    some i
    input.tenant == data.user_tenants[claims.sub][i].tenant
}

claims := payload {
    [_, payload, _] := io.jwt.decode(input.access_token)
}

is_user_granted_role {
    # data.user_tenants[claims.sub][_].role == "admin"
    data.user_tenants[claims.sub][_].role == "admin"
}