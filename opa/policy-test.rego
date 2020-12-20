package example

## not all tests are covered here

test_admin_can_delete_tenant_resource {
    allow with input as {
        "request": {
            "method": "DELETE",
            "query": {},
            "path": "/api/v1/cocacola/upload_token",
            "scheme": "http",
            "host": "localhost",
            "body": {},
            "headers": {
                "host": "localhost:8000",
                "user-agent": "curl/7.64.1",
                "accept": "*/*",
                "authorization": "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6ImhNbmUtMWUyTW5vdUNFeHBlUV9UUiJ9.eyJodHRwOi8vZXhhbXBsZS5jb20vYXV0aG5fbG9hIjoiMiIsImlzcyI6Imh0dHBzOi8vanYtb3BhLmF1LmF1dGgwLmNvbS8iLCJzdWIiOiJhdXRoMHw1ZmRhY2ZkOWI1OWZiYTAwNjk4YTA4NTYiLCJhdWQiOiJodHRwOi8vYnVzaW5lc3MtYXBpMDEiLCJpYXQiOjE2MDgyNjkxMTEsImV4cCI6MTYwODM1NTUxMSwiYXpwIjoiYkRHVjJRYmN2RGM0aEI4TjFXZEhwcjJjMng2Q0pDWGQiLCJzY29wZSI6ImdldDpyZXNvdXJjZSBwb3N0OnJlc291cmNlIGRlbGV0ZTpyZXNvdXJjZSIsImd0eSI6InBhc3N3b3JkIn0.M1ggdi_FrCTLXk0W4drru80zeyDZL5-sgQ5PYFqILqLF3pEf5F0bjYOXhnpcr9_UBcIN0H8OHIQ-BSa28u7qtpffIzxoLljMCH4eeW4wbA3JVwazEhjK7rmFU67ZttKO10M6bJ2rapmnkpqFPopqAkBuMefc4pqtiU9zItw71lnyKOkrMmT7eXUhXB8g3GBB1Pa6XSuUnh-VAAk6MJXRPMtTtgq4-bqdB4mhS56iSBHLpY5ZOhSmX880GCIY2Xnu-B0OLUYwdzWDT6blEtw9klM24MZUan9LEPyMy9ZPxYoRz3NmGnbDqZJkqaRh5SnF1jrKJvAJMDxdLFug36X0SQ"
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

test_admin_cannot_delete_tenant_resource {
    not allow with input as {
        "request": {
            "method": "DELETE",
            "query": {},
            "path": "/api/v1/chevrolet/upload_token",
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

test_admin_can_delete_tenant_resource {
    not allow with input as {
        "request": {
            "method": "DELETE",
            "query": {},
            "path": "/api/v1/chevrolet/upload_token",
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


