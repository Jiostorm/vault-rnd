path "auth/nueca/users/{{ identity.entity.aliases.${AUTH_USER_PASS_ACCESSOR_ID}.name }}" {
  capabilities = [ "update" ]
  allowed_parameters = {
    "password" = []
  }
}

path "auth/nueca/users/{{ identity.entity.aliases.${AUTH_USER_PASS_ACCESSOR_ID}.name }}/password" {
  capabilities = [ "update" ]
}
