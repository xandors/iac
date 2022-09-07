data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}

resource "aws_iam_role" "role" {
  name               = "${local.name}-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "assume_role_admin" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = [aws_iam_role.role.arn]
  }
}

resource "aws_iam_policy" "allow_assume_role" {
  name        = "${local.name}-allow-assume-role"
  description = "Allow assuming role"
  policy      = join("", data.aws_iam_policy_document.assume_role_admin.*.json)
}

resource "aws_iam_group" "group" {
  name = "${local.name}-group"
}

resource "aws_iam_group_policy_attachment" "assume_role_group" {
  group      = aws_iam_group.group.name
  policy_arn = aws_iam_policy.allow_assume_role.arn
}

resource "aws_iam_user" "user" {
  name = "${local.name}-user"
}

resource "aws_iam_user_group_membership" "user_group" {
  user   = aws_iam_user.user.name
  groups = [aws_iam_group.group.name]
}
