storage "postgresql" {
  connection_url = "postgres://${PGSQL_VAULT_USER}:${PGSQL_VAULT_PASS}@${PGSQL_VAULT_HOST}:5432/${PGSQL_VAULT_DB}"
  table = "vault_kv_store"

  ha_enabled = "true"
  ha_table = "vault_ha_locks"
}
 
listener "tcp" {
  address = "0.0.0.0:8200"
  cluster_address = "0.0.0.0:8201"

  tls_disable = 1
}

api_addr = "http://127.0.0.1:8200"
cluster_addr = "http://127.0.0.1:8201"

disable_mlock = 1
allow_audit_log_prefixing = 1

ui = 1
