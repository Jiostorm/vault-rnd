# Vault Guide
## Vault Core Commands
- `secrets` <`list`|`enable`|`disable`|`tune`>
    - options:
        - `-path`
        - `-description`
- `kv` <`list`|`get`|`put`|`patch`|`delete`>
    - `metadata` <`get`|`put`|`patch`|`delete`>
    - options:
        - `-mount`
        - `-path`
        - `-field`
- `policy` <`list`|`read`|`write`|`delete`>
- `auth` <`list`|`enable`|`disable`|`tune`>
    - options:
        - `-path`
        - `-description`
- `audit` <`list`|`enable`|`disable`>
    - options:
        - `-path`
        - `-description`

## Vault Operator Commands
- `init`
- `seal`
- `unseal`
- `login`

## Vault REST API Commands
- `read`
- `write`
- `patch`
- `delete`


# Vault Setup
## Server
### Starting Vault Server
```sh
vault server -config=</path/to/config.hcl>
```

### Initializing Vault Operator
```sh
vault operator init
```

### Unseal Vault
> [!NOTE]
> Vault by default has an unseal key threshold of 3 only from 5 unseal keys
```sh
vault operator unseal
```

### Logging-in to Vault using _root_ token
> [!TIP]
> Or set `VAULT_TOKEN` environment variable to bypass login
```sh
vault login -method=token
```

### Logging-in to Vault using _userpass_
```sh
vault login \
    -method=userpass \
    -path="<custom-auth-path>" \
    username="<username>"
```


## Secrets
### Enable _KV(Key-Value) v2_ engine
```sh
vault secrets enable \
    -path="<custom-path>" \
    -description="<description>" \
    kv-v2
```

### Writing a secret to KV v2
> [!NOTE]
> KV-v2 secrets engine inserts an additional path to secrets @ `/<custom-path>/data/<secret-name>`
```sh
vault kv put \
    -mount="<custom-path>" \
    <secret-name> \
    <field-1>=<value-1> \
    <field-2>=<value-2>
    
```


## Policy
### Writing a policy
> [!TIP]
> Piping the contents of a file or using _heredoc_ is permitted for `write` command, via asserting `stdin` using `-`
```sh
vault policy write <policy-name> <filepath>
```


## Auth
### _UserPass_
#### Enable _userpass_ auth
```sh
vault auth enable \
    -path="<custom-path>" \
    -description="<description>" \
    -default-lease-ttl="1h" \
    -max-lease-ttl="12h" \
    userpass
```

#### Writing a _userpass_ auth
```sh
vault write auth/<custom-path>/users/<username> \
    password="<password>" \
    token_policies="<policy>"
```

### _JWT_
#### Enable _jwt_ auth
```sh
vault auth enable \
    -path="<custom-path>" \
    -description="<description>" \
    -default-lease-ttl="1h" \
    -max-lease-ttl="12h" \
    jwt
```

#### Writing a _jwt_ auth `config`
```sh
vault write auth/<custom-path>/config \
    oidc_discovery_url="<oidc/jwt-url>" \
    bound_issuer="<bound-audience-url>"
```

#### Writing a _jwt_ auth role
```sh
vault write auth/<custom-path>/role/<role-name> - <<-HERE
{
  "bound_audiences": "$REPO_URL",
  "bound_claims_type": "glob",
  "bound_claims": {
    "project_id": "$PROJECT_ID",
    "ref_type": "*",
    "ref": "*"
  },
  "role_type": "jwt",
  "token_max_ttl": "2m",
  "token_num_uses": 1,
  "token_policies": ["${POLICY_PREFIX}-all"],
  "token_ttl": "1m",
  "token_type": "default",
  "user_claim": "user_email"
HERE
```


## Audit
### Enable _file_ audit device
```sh
vault audit enable \
    -path="<custom-path>" \
    -description="<description>" \
    file \
    file_path="<storage-path>"
```

> [!TIP]
> Streaming audit logs to _stdout_ is also possible by setting `file_path=stdout` and
> log prefixing is recommended for easy filtering of audit logs from server logs
```sh
vault audit enable \
    -path="<custom-path>" \
    -description="<description>" \
    file \
    file_path="stdout" \
    prefix="<custom-prefix>"
```

> [!TIP]
> Streaming audit logs to a log file is also desired with streaming to _stdout_ for better logging capability
```sh
vault audit enable \
    -path="<custom-path>" \
    -description="<description>" \
    file \
    file_path="<audit-log-path>" \
    hmac_accessor=false \
    elide_list_responses=true
```

# References

[Official Hashicorp Vault](https://developer.hashicorp.com/vault/docs)
