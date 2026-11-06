# Actions need Terraform 1.14+ and a provider version that ships the action
terraform {
  required_version = ">= 1.14"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.15"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

action "aws_ec2_stop_instance" "example" {
  config {
    instance_id = aws_instance.main.id
  }
}

resource "aws_instance" "main" {
  ami           = var.ami
  instance_type = "t3.small"

  lifecycle {
    # The action_trigger block links the action to lifecycle events
    action_trigger {
      events = [
        after_create,
        after_update
      ]
      actions = [
        action.aws_ec2_stop_instance.example # Reference the action by its address
      ]
    }
  }

}

variable "ami" {
  default = "ami-0eec78ea4cbaaf5bd"
}

## An action can also be run on demand:
##   terraform apply -invoke=action.aws_ec2_stop_instance.example

# resource "terraform_data" "restart_trigger" {
#   triggers_replace = [
#     aws_instance.main.ami
#   ]
#
#   provisioner "local-exec" {
#     command = "echo 'Instance ${aws_instance.main.id} was recreated with AMI ${var.ami}'"
#   }
# }
