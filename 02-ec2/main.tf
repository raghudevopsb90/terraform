provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "main" {
  ami           = "ami-0220d79f3f480ecf5"
  instance_type = "t3.micro"

  tags = {
    Name = "test"
  }
}

# One resource referring to another resource's attribute.
# Terraform understands the dependency and creates the instance first.
resource "aws_route53_record" "main" {
  zone_id = var.zone_id
  name    = "test"
  type    = "A"
  ttl     = 30
  records = [aws_instance.main.private_ip]
}

variable "zone_id" {
  default = "Z057881017RC0RRKVUX8E"
}

output "private_ip" {
  value = aws_instance.main.private_ip
}
