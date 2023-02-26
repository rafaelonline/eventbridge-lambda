# Eventos orientados com Amazon EventBridge

As arquiteturas orientadas a eventos (Event-Driven) são caracterizadas por serviços que se comunicam de forma assíncrona e desacoplado através de eventos.

Os serviços transmitirão eventos (Produtores) que serão consumidos e reagidos por outros serviços (Consumidores).

Uma característica que marca uma Arquitetura Event-Drive é que: Produtores e consumidores estão completamente dissociados, um produtor não deve saber ou se importar com quem está consumindo seus eventos.

![Event-Driven Architectures Draw](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/s8zblbucxrr1dtmtdyko.png)

## O que seria o Amazon EventBridge?

> O [Amazon EventBridge](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-what-is.html) é um serviço que oferece acesso em tempo real a alterações de dados em serviços da AWS, em suas aplicações e em aplicações de software como serviço (SaaS) sem precisar escrever código. Para começar, você pode escolher uma origem de eventos no console do EventBridge. Em seguida, pode selecionar um destino entre os serviços da AWS, incluindo o AWS Lambda, o Amazon Simple Notification Service (SNS) e o Amazon Kinesis Data Firehose. O EventBridge entregará automaticamente os eventos quase em tempo real.

Em resumo você pode receber, filtrar, transformar, rotear (dos Produtores) e entregar esses eventos a Consumidores.

## Trabalhando com o Amazon EventBridge

Para exemplificar o uso do Amazon EventBridge vamos criar o seguinte cenário:

* Toda vez que uma instancia RDS for criada queremos que uma Lambda seja executada. Para nosso exemplo a Lambda irá adicionar uma tag.

Utilizaremos então a seguinte arquitetura:

![Event-Driven Architectures exemple](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/zni56gp7j5zta4ymrppq.png)

1. Como **Produtor** de eventos utilizaremos o _CloudTrail_.
2. Como **Broker**, que irá tratar os eventos, utilizaremos o _EventBridge_
3. Como **Consumer** desses eventos utilizaremos a _AWS Lambda_

Acesse o post comeplento em [Eventos orientados com Amazon EventBridge](https://dev.to/rafaelonline/eventos-orientados-com-amazon-eventbridge-1185)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.7 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | ~> 2.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.54.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | ~> 2.3.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.54.0 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudtrail.cloudtrail_autotag](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail) | resource |
| [aws_cloudwatch_event_rule.aurora_event_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_rule.rds_event_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.lambda_rule_aurora](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_event_target.lambda_rule_rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_log_group.lambda_log_grp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_role.lambda_exec_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_lambda_function.autotag](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.event_brige](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_s3_bucket.cloudtrail_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.cloudtrail_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [random_pet.cloudtrail_bucket_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [archive_file.lambda_autotag](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [aws_iam_policy_document.cloudtrail_bucket_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda_inline_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_autotag_description"></a> [autotag\_description](#input\_autotag\_description) | Name of lambda function | `string` | `"Add tags on RDS Instance and Aurora Cluster"` | no |
| <a name="input_autotag_function_name"></a> [autotag\_function\_name](#input\_autotag\_function\_name) | Name of lambda function | `string` | `"add_tag_rds"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region for all resources. | `string` | `"us-east-1"` | no |
| <a name="input_create_trail"></a> [create\_trail](#input\_create\_trail) | Set to false if a Cloudtrail trail for management events exists | `bool` | `true` | no |
| <a name="input_lambda_tag_key"></a> [lambda\_tag\_key](#input\_lambda\_tag\_key) | Lambda Tag Key | `string` | `"squad"` | no |
| <a name="input_lambda_tag_value"></a> [lambda\_tag\_value](#input\_lambda\_tag\_value) | Lambda Tag Key | `string` | `"dba"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->