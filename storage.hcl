storage "postgresql" {
  connection_url = "postgres://${PGSQL_VAULT_USER}:${PGSQL_VAULT_PASS}@${PGSQL_VAULT_HOST}:5432/${PGSQL_VAULT_DB}"
  table = "vault_kv_store"

  ha_enabled = "true"
  ha_table = "vault_ha_locks"
}
