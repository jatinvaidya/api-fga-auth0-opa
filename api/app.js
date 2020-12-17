const express = require('express');
const app = express();

const bodyParser = require('body-parser');
const extAuthz = require('@build-security/opa-express-middleware');
const expressJwt = require('express-jwt');
const expressJwtAuthz = require('express-jwt-authz');
const jwksRsa = require('jwks-rsa');

require('dotenv').config();

const port = process.env.PORT || 8000;
if (!process.env.AUTH0_DOMAIN || !process.env.AUTH0_AUDIENCE) {
    throw ('please have all values in your .env file, refer to .env.sample');
}

const verifyAccessToken = expressJwt({
    // dynamically fetch and cache JWKS public key
    secret: jwksRsa.expressJwtSecret({
        cache: true,
        rateLimit: true,
        jwksRequestsPerMinute: 5,
        jwksUri: `https://${process.env.AUTH0_DOMAIN}/.well-known/jwks.json`
    }),
    // validate aud, iss claims
    audience: process.env.AUTH0_AUDIENCE,
    issuer: `https://${process.env.AUTH0_DOMAIN}/`,
    algorithms: ['RS256']
});

const checkCrudResourceScope = expressJwtAuthz(['crud:resource']);
const checkDeleteTenantScope = expressJwtAuthz(['delete:tenant']);

const enforceAuthzPolicy = extAuthz((req) => ({
    authzServer: "http://localhost:8181/v1/data/authz",
}));

app.use(bodyParser.json());

// public endpoint
app.get('/', (req, res) => {
    res.json({
        message: 'This is the tenant resource service for example.com'
    });
});

// private endpoints
app.get('/api/v1/:tenant/:resource', 
        verifyAccessToken, checkCrudResourceScope, 
        enforceAuthzPolicy, (req, res) => {
    let tenant = req.params.tenant;
    let resource = req.params.resource;
    let action = (resource === 'upload_token') ? 'VALIDATE' : 'INDEX';
    let message = 'authorization check success';
    res.json({ tenant, resource, action, message });
});

app.post('/api/v1/:tenant/:resource', 
        verifyAccessToken, checkCrudResourceScope, (req, res) => {
    let tenant = req.params.tenant;
    let resource = req.params.resource;
    let action = 'CREATE';
    let message = 'authorization check success';
    res.json({ tenant, resource, action, message });
});

app.delete('/api/v1/:tenant', 
        verifyAccessToken, checkDeleteTenantScope, (req, res) => {
    let tenant = req.params.tenant;
    let action = 'DELETE';
    let message = 'authorization check success';
    res.json({ tenant, action, message });
});

app.use((err, req, res, next) => {
    console.error(err.stack);
    return res.status(err.status).json({ message: err.message });
});

app.listen(port, () => {
    console.log(`Now listening on http://localhost:${port}`)
});
