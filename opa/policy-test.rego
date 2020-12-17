package com.example.fga.demo

test_admin_can_delete_tenant {
    allow with input as {
        "request": {
            "method": "DELETE",
            "query": {},
            "path": "/api/v1/cocacola",
            "scheme": "http",
            "host": "localhost",
            "body": {},
            "headers": {
                "host": "localhost:8000",
                "user-agent": "curl/7.64.1",
                "accept": "*/*",
                "authorization": "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6ImhNbmUtMWUyTW5vdUNFeHBlUV9UUiJ9.eyJpc3MiOiJodHRwczovL2p2LW9wYS5hdS5hdXRoMC5jb20vIiwic3ViIjoiMnZ4bG9OaDhKUGpUeXpjcGFST1ZtdkZmQjhBWkxiWk9AY2xpZW50cyIsImF1ZCI6Imh0dHA6Ly9idXNpbmVzcy1hcGkwMSIsImlhdCI6MTYwODE3ODE4OSwiZXhwIjoxNjA4MjY0NTg5LCJhenAiOiIydnhsb05oOEpQalR5emNwYVJPVm12RmZCOEFaTGJaTyIsInNjb3BlIjoiZGVsZXRlOnRlbmFudCBjcnVkOnJlc291cmNlIiwiZ3R5IjoiY2xpZW50LWNyZWRlbnRpYWxzIn0.AHiM1vllVeDgzXHhpS7cJU-2sCg3H3aQG7yC2GJttwPkpUYL75aFJvxUK4Ke_oeqmaxCNXrK4R48766yIV-yzqGsWGRmE4dSQB08cdFrANlEZ_k8SZks0cUgdMD4G_Py2cHjbS2oXK04tNydTRpeL_iGAmLT5k0iR5IdkpLD8PDDBuQygUGtCnji7N4Sw3aG0huakpDo3m27SB5g3ti1UMmycjSD620mrB_NaLTP3LJCMlqzSRCvcxMQT_ChFFxDQAJl2SUvNys43SQX5ZmN_X3nRGMKZsy33tUd6qw4H7eWgJCvVJt6vAEHxYzMTSIDb-olgzo5Wc1K9MbPNNFOjA"
            }
        },
        "source": {
            "port": 57816,
            "address": "::1"
        },
        "destination": {
            "port": 8000,
            "address": "::1"
        }
    }
}

