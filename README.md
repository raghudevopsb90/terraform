# terraform

Terraform examples in teaching order, one topic per folder. Each folder is a separate
working directory: `cd` into it and run `terraform init`, `plan`, `apply`, `destroy`.

Most examples come from the earlier batches' `learn-terraform` repos (mainly d88, the latest
AWS batch). Missing pieces were added from other batches or written new (marked **new** below).

## Teaching order

| # | Folder | What to teach | Source |
|---|--------|---------------|--------|
| 01 | `01-resource` | Resource and output syntax, `init / plan / apply / destroy`, provider download, the state file | d88 + output (d81) |
| 02 | `02-ec2` | `provider` block, first EC2 instance, tags, one resource referring to another's attribute (Route53 record → instance IP) | d88 + d87 |
| 03 | `03-variables` | string / number / bool / list / map, `${}` interpolation, indexing, `type` constraints, a variable with no default (`-var`) | d88 + d87 |
| 04 | `04-tfvars` | `-var-file=dev.tfvars` vs `prod.tfvars` | d88 |
| 05 | `05-auto-tfvars` | `*.auto.tfvars` loaded automatically, one folder per env | d88 |
| 06 | `06-datasource` | `data` blocks: look up AMI and security group, then use them in an instance | d88 + d87 |
| 07 | `07-count` | `count`, `count.index`, `length()`, the index-shift problem with count | d88 + d72/d89 |
| 08 | `08-for-each` | `for_each` on a map, a map of maps (`each.key`, `each.value`), `toset()` on lists | d88 + d72 |
| 09 | `09-splat-and-for-expressions` | `[for ...]`, `{for ... => ...}`, `[*]` splat, `if` filter | d88 + d89 |
| 10 | `10-conditions` | ternary operator, `count = cond ? 1 : 0` to make a resource optional | d88 + d87/d84/d89 |
| 11 | `11-functions` | string functions, `element`, `lookup`, `try`, `terraform console` | d88 + d74 |
| 12 | `12-locals` | `locals` to compute and reshape values | d88 + d87 |
| 13 | `13-dynamic-blocks` | `dynamic "ingress"` instead of repeating blocks | d88 + egress fix |
| 14 | `14-provisioner` | `local-exec`, `remote-exec`, `connection`, `self` | d88 |
| 15 | `15-null-resource-provisioner` | moving provisioners into `null_resource`, `triggers` to re-run them | d88 + d89 |
| 16 | `16-modules` | module inputs and outputs, reusing a module, passing one module's output into another | d88 + d89 |
| 17 | `17-remote-state` | S3 backend, `use_lockfile` state locking | d88 + d89 |
| 18 | `18-custom-backend-remote-state` | empty backend + `terraform init -backend-config=state.tfvars` | d88 |
| 19 | `19-multi-env-code-structure` | one codebase, `env-dev/` and `env-prod/` var and state files, Makefile | d81 |
| 20 | `20-lifecycle` | `create_before_destroy`, `prevent_destroy`, `ignore_changes` | d88 (fixed) |
| 21 | `21-import` | `import` block, `-generate-config-out`, `terraform import` CLI | **new** (d72 only had the resource) |
| 22 | `22-hashicorp-vault` | reading secrets from Vault, `sensitive` | d84 + d85 |
| 23 | `23-terraform-actions` | Terraform 1.14 `action` + `action_trigger`, `-invoke` | d88 |

## Commands per topic

```sh
# 03
terraform apply -var input=hello

# 04
terraform apply -var-file=dev.tfvars
terraform apply -var-file=prod.tfvars

# 05
cd dev && terraform apply        # dev.auto.tfvars is picked up automatically

# 11
terraform console                # then try: upper("abc"), element(["a","b"], 3)

# 17 - create the S3 bucket first
terraform init

# 18
terraform init -backend-config=state.tfvars

# 19
make apply env=dev
make destroy env=dev

# 21
terraform plan -generate-config-out=generated.tf

# 22
terraform apply -var token=<vault-token>
```

## Before class

- AMI `ami-0220d79f3f480ecf5`, security group `sg-09b871cf63e2bb80b`, and the Route53 zone ID are
  from earlier batches. Update them for your account, or replace them with data sources (as in `06`).
- Create the S3 bucket `terraform-state-d90` before topics 17–19.
- Set the Vault address in `22-hashicorp-vault/main.tf` to your Vault server.
- Topic 23 needs Terraform >= 1.14 and AWS provider >= 6.15.

## Optional extras if time allows

Not covered in any batch yet: `terraform_remote_state` data source, workspaces,
variable `validation` blocks, `moved` blocks, `templatefile()`.
