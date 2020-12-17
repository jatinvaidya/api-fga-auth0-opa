function requireMfaOncePerSession(user, context, callback) {
    
    const namespace = 'http://example.com/';
    const completedMfa = !!context.authentication.methods.find(
        (method) => method.name === 'mfa'
    );

    // insert any other conditional logic here.
    if (completedMfa) {
        context.accessToken[namespace + 'authn_loa'] = '2';
        return callback(null, user, context);
    }

    context.multifactor = {
        provider: 'any',
        allowRememberBrowser: false
    };

    callback(null, user, context);
}