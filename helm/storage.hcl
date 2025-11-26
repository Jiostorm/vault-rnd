storage "postgresql" {
  connection_url = "postgres://${VAULT_PGSQL_ADMIN}:${VAULT_PGSQL_PASS}@${VAULT_PGSQL_HOST}:5432/${VAULT_PGSQL_DB}?sslmode=disable"
  table = "vault_kv_store"

  ha_enabled = "true"
  ha_table = "vault_ha_locks"
}
