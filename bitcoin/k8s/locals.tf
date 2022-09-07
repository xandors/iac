locals {
  name   = "${var.environment}-${var.project}"
  region = data.aws_region.current.name

  tags = {
    environment = var.environment
    project     = var.project
  }
}
