path "${SECRET_MOUNT}/data/*" {
  capabilities = ["read", "list", "patch"]
}

path "${SECRET_MOUNT}/metadata/*" {
  capabilities = ["read", "list"]
}
