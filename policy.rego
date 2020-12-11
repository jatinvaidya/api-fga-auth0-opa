package com.example.fga.demo

default allow = false

allow {
    input.action == "list"
    input.resource == "content_route"

    some i
    input.tenant == data.user_tenants[claims.sub][i].tenant
    data.user_tenants[claims.sub][i].role == "admin"
}

allow {
    input.action == "upload"
    input.resource == "tokens"

    some i
    input.tenant == data.user_tenants[claims.sub][i].tenant
    data.user_tenants[claims.sub][i].role == "admin"
}

allow {
    input.action == "upload"
    input.resource == "token"

    some i
    input.tenant == data.user_tenants[claims.sub][i].tenant
    data.user_tenants[claims.sub][i].role == "poweruser"
}

allow {
    input.action == "index"
    input.resource == "vpc"

    some i
    input.tenant == data.user_tenants[claims.sub][i].tenant
    data.user_tenants[claims.sub][i].role == "admin"
}

allow {
    input.action == "validate"
    input.resource == "token"

    some i
    input.tenant == data.user_tenants[claims.sub][i].tenant
}

claims := payload {
	[_, payload, _] := io.jwt.decode(input.access_token)
}



