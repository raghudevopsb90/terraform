# Usage: make apply env=dev   |   make destroy env=prod

init:
	rm -rf .terraform *.auto.tfvars
	terraform init -backend-config=env-$(env)/state.tfvars
	cp env-$(env)/*.auto.tfvars . # This only command saves a lot and lot of TF code and avoid module for a single project mono repo.

plan: init
	terraform plan -var-file=env-$(env)/main.tfvars

apply: init
	terraform apply -auto-approve -var-file=env-$(env)/main.tfvars

destroy: init
	terraform destroy -auto-approve -var-file=env-$(env)/main.tfvars
