module "sample" {
  source  = "./sample"
  message = var.message
  a       = var.a
  b       = var.b
}

# Same module used again, taking input from the first module's output
module "sample1" {
  source  = "./sample"
  message = "Output of first module is ${module.sample.multiply}"
  a       = module.sample.multiply
  b       = 2
}

variable "message" {
  default = "Hello World"
}

variable "a" {
  default = 10
}

variable "b" {
  default = 200
}

output "output_from_module" {
  value = module.sample.multiply
}

output "output_from_module1" {
  value = module.sample1.multiply
}
