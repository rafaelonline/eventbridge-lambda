############ EVENTBRIDGE RULE - CREATED RDS INSTANCE ############
resource "aws_cloudwatch_event_rule" "rds_event_rule" {
  name          = "rule-rds-created"
  description   = "Triggers Lambda when new RDS instance are created"
  is_enabled    = true
  event_pattern = <<EOF
    {
    "source": ["aws.rds"],
    "detail-type": ["AWS API Call via CloudTrail"],
    "detail": {
        "eventSource" : ["rds.amazonaws.com"],
        "eventName": ["CreateDBInstance"]
    }
    }
  EOF
}

############ EVENTBRIDGE TARGET - CREATED RDS INSTANCE ############
resource "aws_cloudwatch_event_target" "lambda_rule_rds" {
  depends_on = [aws_lambda_function.autotag]
  rule       = aws_cloudwatch_event_rule.rds_event_rule.name
  target_id  = "SendToLambda"
  arn        = aws_lambda_function.autotag.arn
}

############ EVENTBRIDGE RULE - CREATED CLUSTER AURORA ############
resource "aws_cloudwatch_event_rule" "aurora_event_rule" {
  name          = "rule-aurora-created"
  description   = "Triggers Lambda when new Cluster Aurora are created"
  is_enabled    = true
  event_pattern = <<EOF
    {
    "source": ["aws.rds"],
    "detail-type": ["AWS API Call via CloudTrail"],
    "detail": {
        "eventSource" : ["rds.amazonaws.com"],
        "eventName": ["CreateDBCluster"]
    }
    }
  EOF
}

############ EVENTBRIDGE TARGET - CREATED CLUSTER AURORA ############
resource "aws_cloudwatch_event_target" "lambda_rule_aurora" {
  depends_on = [aws_lambda_function.autotag]
  rule       = aws_cloudwatch_event_rule.aurora_event_rule.name
  target_id  = "SendToLambda"
  arn        = aws_lambda_function.autotag.arn
}