######################## GENERATE PACKAGE LAMBDA ######################## 
data "archive_file" "lambda_autotag" {
  type        = "zip"
  source_dir  = "${path.module}/code/src"
  output_path = "${path.module}/code/lambda_package.zip"
}

######################## LAMBDA FUNCTION ########################
resource "aws_lambda_function" "autotag" {
  function_name    = var.autotag_function_name
  role             = aws_iam_role.lambda_exec_role.arn
  filename         = data.archive_file.lambda_autotag.output_path
  source_code_hash = data.archive_file.lambda_autotag.output_base64sha256
  description      = var.autotag_description
  publish          = true

  runtime       = "python3.8"
  handler       = "main.lambda_handler"
  timeout       = 300
  memory_size   = 128
  architectures = ["arm64"]

  environment {
    variables = {
      TAG_KEY   = var.lambda_tag_key
      TAG_VALUE = var.lambda_tag_value
    }
  }
}

######################## LAMBDA LOG GROUP ########################
resource "aws_cloudwatch_log_group" "lambda_log_grp" {
  name              = "/aws/lambda/${var.autotag_function_name}"
  retention_in_days = 3
}

######################## LAMBDA PERMISSION TO EVENT BRIGE ########################
resource "aws_lambda_permission" "event_brige" {
  depends_on    = [aws_lambda_function.autotag]
  statement_id  = "AllowExecutionFromEventBridgeRule"
  action        = "lambda:InvokeFunction"
  function_name = var.autotag_function_name
  principal     = "events.amazonaws.com"
}



