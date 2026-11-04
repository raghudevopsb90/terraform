# Run with: terraform apply -var token=<vault-token>

provider "vault" {
  address = "http://vault.rdevopsb90.online:8200"
  token   = var.token
}

variable "token" {
  sensitive = true
}

data "vault_generic_secret" "secret" {
  path = "demo/ssh"
}

output "secret" {
  value     = data.vault_generic_secret.secret
  sensitive = true # terraform output -json secret  to see it
}

resource "local_file" "foo" {
  content  = jsonencode(data.vault_generic_secret.secret.data)
  filename = "/tmp/vault"
}

resource "local_file" "foo1" {
  content  = data.vault_generic_secret.secret.data["password"]
  filename = "/tmp/vault-pass"
}
