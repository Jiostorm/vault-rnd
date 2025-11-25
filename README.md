# Vault Command Guide
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
- `vault server -config=/path/to/config.hcl`

### Initializing Vault Operator
- `vault operator init`

### Unseal Vault
> [!NOTE]
> Vault by default has an unseal key threshold of 3 only from 5 unseal keys
- `vault operator unseal`

### Logging-in to Vault
> [!TIP]
> Or set `VAULT_TOKEN` environment variable to bypass login
- `vault login -method=token`


## Secrets
### Enable _KV(Key-Value) v2_ engine
- `vault secrets enable -path="<custom-path>" -description="<description>" kv-v2`

### Writing a secret to KV v2
> [!NOTE]
> KV-v2 secrets engine inserts an additional path to secrets @ `/<custom-path>/data/<secret-name>`
- `vault kv put -mount="<custom-path>" -field="<optional-field>" <secret-name>`


## Policy
### Writing a policy
> [!TIP]
> Piping the contents of a file or using _heredoc_ is permitted for `write` command, via asserting `stdin` using `-`
- `vault policy write <policy-name> <filepath>`


## Auths
### Enable _userpass_ auth
- `vault auth enable -path="<custom-path>" -description="<description>" userpass`

### Writing a _userpass_ auth
- `vault write auth/<custom-path>/users/<username> password="<password>" token_policies="<policy>"`


## Audit
### Enable _file_ audit device
- `vault audit enable -path="<custom-path>" -description="<description>" file file_path="<storage-path>"`

> [!TIP]
> Streaming audit logs to _stdout_ is also possible by setting `file_path=stdout` and
> log prefixing is recommended for easy filtering of audit logs from server logs
- `vault audit enable -path="<custom-path>" -description="<description>" file file_path="stdout" -prefix="<custom-prefix>"`
