const axios = require('axios');
require('dotenv').config();

const argv = require('yargs').options({
    username: { type: 'string', describe: 'user email', demandOption: true },
    password: { type: 'string', describe: 'user password', demandOption: true },
    tenant: { type: 'string', describe: 'customer org', demandOption: true },
    resource: { type: 'string', describe: 'customer org resource', demandOption: true },
    action: { type: 'string', describe: 'action on resource (GET|POST|DELETE)', demandOption: true }
}).usage('e.g. usage: $0 --username admin01@example.com --password Mju76yhn --tenant cocacola --resource vpc --action GET').argv;

let getAccessToken = async () => {

    // access token request
    const options = {
        method: 'POST',
        url: `https://${process.env.AUTH0_DOMAIN}/oauth/token`,
        headers: {
            'content-type': 'application/json'
        },
        data: {
            grant_type: 'http://auth0.com/oauth/grant-type/password-realm',
            realm: `${process.env.REALM}`,
            username: `${argv.username}`,
            password: `${argv.password}`,
            audience: `${process.env.API_AUDIENCE}`,
            scope: `${process.env.API_SCOPE}`,
            client_id: `${process.env.CLIENT_ID}`,
            client_secret: `${process.env.CLIENT_SECRET}`
        }
    };

    // get access_token
    return axios(options)
        .then(response => response.data.access_token)
        .catch(error => console.log(error.message));
};

// get access_token and then make an api call
let makeApiCall = async () => {
    const accessToken = await getAccessToken();
    console.log(`[1] access_token: ${accessToken}`);
    // generic api call request
    // make a few API calls
    const options = {
        url: `http://${process.env.API_HOST}:${process.env.API_PORT}/api/v1/${argv.tenant}/${argv.resource}`,
        method: `${argv.action}`,
        headers: {
            'content-type': 'application/json',
            'authorization': `Bearer ${accessToken}`
        }
    };
    axios(options)
        .then(response => {
            console.log(`${response.data.message}`);
        }).catch(error => console.log(error.message));
};

makeApiCall();