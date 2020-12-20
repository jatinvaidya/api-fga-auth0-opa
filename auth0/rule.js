function requireMfaOncePerSession(user, context, callback) {
  
    const namespace = 'http://example.com/';

    // any other scope does not need MFA
    // this is CGA (Coarse Grained Authz)
    const elevatedScope = 'delete:resource';   
        
    const requiredMfa = !!context.request.body.scope.split(' ').find(
      (scope) => scope === elevatedScope
    );
    const completedMfa = !!context.authentication.methods.find(
      (method) => method.name === 'mfa'
    );
  
    if (requiredMfa && completedMfa) {
      context.idToken[namespace + 'authn_loa'] = '2';
      context.accessToken[namespace + 'authn_loa'] = '2';
      return callback(null, user, context);
    }
  
    context.multifactor = {
      provider: 'any',
      allowRememberBrowser: false
    };
    
    callback(null, user, context);
  }