data "aws_security_group" "selected" {
  filter {
    name   = "group-name"
    values = ["allow-all"]
  }
}

resource "aws_instance" "instance" {
  ami                    = "ami-0220d79f3f480ecf5"
  instance_type          = var.env == "prod" ? "t3.medium" : "t3.small"
  vpc_security_group_ids = [data.aws_security_group.selected.id]

  tags = {
    Name = "test-${var.env}"
  }
}

variable "env" {}
