# Usage: make apply env=dev   |   make destroy env=prod

init:
	rm -rf .terraform
	terraform init -backend-config=env-$(env)/state.tfvars

plan: init
	terraform plan -var-file=env-$(env)/main.tfvars

apply: init
	terraform apply -auto-approve -var-file=env-$(env)/main.tfvars

destroy: init
	terraform destroy -auto-approve -var-file=env-$(env)/main.tfvars
