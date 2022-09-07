
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  name = local.name
  cidr = "10.0.0.0/16"

  azs             = [for az in var.azs : "${local.region}${az}"]
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_flow_log                      = true
  create_flow_log_cloudwatch_iam_role  = true
  create_flow_log_cloudwatch_log_group = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.name}" = "shared"
    "kubernetes.io/role/elb"              = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.name}" = "shared"
    "kubernetes.io/role/internal-elb"     = 1
  }

  tags = local.tags
}

# module "eks" {
#   source  = "terraform-aws-modules/eks/aws"
#   version = "~> 18.0"

#   cluster_name                    = local.name
#   cluster_endpoint_private_access = true
#   cluster_endpoint_public_access  = true

#   cluster_addons = {
#     coredns = {
#       resolve_conflicts = "OVERWRITE"
#     }
#     kube-proxy = {}
#     vpc-cni = {
#       resolve_conflicts = "OVERWRITE"
#     }
#   }

#   # Encryption key
#   create_kms_key = true
#   cluster_encryption_config = [{
#     resources = ["secrets"]
#   }]
#   kms_key_deletion_window_in_days = 7
#   enable_kms_key_rotation         = true

#   vpc_id                   = module.vpc.vpc_id
#   subnet_ids               = module.vpc.private_subnets

#   # Extend cluster security group rules
#   cluster_security_group_additional_rules = {
#     egress_nodes_ephemeral_ports_tcp = {
#       description                = "To node 1025-65535"
#       protocol                   = "tcp"
#       from_port                  = 1025
#       to_port                    = 65535
#       type                       = "egress"
#       source_node_security_group = true
#     }
#   }

#   # Extend node-to-node security group rules
#   node_security_group_ntp_ipv4_cidr_block = ["169.254.169.123/32"]
#   node_security_group_additional_rules = {
#     ingress_self_all = {
#       description = "Node to node all ports/protocols"
#       protocol    = "-1"
#       from_port   = 0
#       to_port     = 0
#       type        = "ingress"
#       self        = true
#     }
#     egress_all = {
#       description      = "Node all egress"
#       protocol         = "-1"
#       from_port        = 0
#       to_port          = 0
#       type             = "egress"
#       cidr_blocks      = ["0.0.0.0/0"]
#       ipv6_cidr_blocks = ["::/0"]
#     }
#   }

#   # Self Managed Node Group(s)
#   self_managed_node_group_defaults = {
#     vpc_security_group_ids       = [aws_security_group.additional.id]
#     iam_role_additional_policies = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
#   }

#   self_managed_node_groups = {
#     spot = {
#       instance_type = "m5.large"
#       instance_market_options = {
#         market_type = "spot"
#       }

#       pre_bootstrap_user_data = <<-EOT
#       echo "foo"
#       export FOO=bar
#       EOT

#       bootstrap_extra_args = "--kubelet-extra-args '--node-labels=node.kubernetes.io/lifecycle=spot'"

#       post_bootstrap_user_data = <<-EOT
#       cd /tmp
#       sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
#       sudo systemctl enable amazon-ssm-agent
#       sudo systemctl start amazon-ssm-agent
#       EOT
#     }
#   }

#   # OIDC Identity provider
#   cluster_identity_providers = {
#     sts = {
#       client_id = "sts.amazonaws.com"
#     }
#   }

#   # aws-auth configmap
#   manage_aws_auth_configmap = true

#   aws_auth_roles = [
#     {
#       rolearn  = "arn:aws:iam::66666666666:role/role1"
#       username = "role1"
#       groups   = ["system:masters"]
#     },
#   ]

#   aws_auth_users = [
#     {
#       userarn  = "arn:aws:iam::66666666666:user/user1"
#       username = "user1"
#       groups   = ["system:masters"]
#     },
#     {
#       userarn  = "arn:aws:iam::66666666666:user/user2"
#       username = "user2"
#       groups   = ["system:masters"]
#     },
#   ]

#   aws_auth_accounts = [
#     "777777777777",
#     "888888888888",
#   ]

#   tags = local.tags
# }
