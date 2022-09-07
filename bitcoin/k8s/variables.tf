variable "environment" { default = "prod" }
variable "project" { default = "ci" }
variable "azs" { default = ["a", "b", "c"] }
variable "private_subnets" { default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"] }
variable "public_subnets" { default = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"] }
