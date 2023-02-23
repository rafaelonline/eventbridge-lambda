######################## LAMBDA IAM ROLE ########################
resource "aws_iam_role" "lambda_exec_role" {
  name               = "lambda-autotag-rds"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
  inline_policy {
    name   = "AutotagFunctionPermissions"
    policy = data.aws_iam_policy_document.lambda_inline_policy.json
  }
}

######################## LAMBDA ROLE TRUST POLICY ########################
data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

######################## LAMBDA ROLE PERMISSIONS ########################
data "aws_iam_policy_document" "lambda_inline_policy" {
  statement {
    sid       = "AllowTaggingOfRDS"
    effect    = "Allow"
    actions   = ["rds:AddTagsToResource", "rds:ListTagsForResource", "rds:RemoveTagsFromResource"]
    resources = ["*"]
  }
  statement {
    sid       = "AllowLambdaCreateLogGroup"
    effect    = "Allow"
    actions   = ["logs:CreateLogGroup"]
    resources = ["arn:aws:logs:${var.aws_region}:*:log-group:*"]
  }
  statement {
    sid       = "AllowLambdaCreateLogStreamsAndWriteEventLogs"
    effect    = "Allow"
    actions   = ["logs:CreateLogStream", "logs:PutLogEvents"]
    resources = ["${aws_cloudwatch_log_group.lambda_log_grp.arn}:*"]
  }
}