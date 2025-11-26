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
