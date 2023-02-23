"""Add tags on RDS and Aurora."""
import logging
import os
import boto3
from botocore.exceptions import ClientError

# Config Logging.
log = logging.getLogger()
log.setLevel(logging.INFO)

def lambda_handler(event, context):
    """Add tags on RDS and Aurora"""

    # Define the tags to add to the RDS instance
    tag_key = os.environ.get('TAG_KEY')
    tag_value = os.environ.get('TAG_VALUE')
    tags = [
        {
            'Key': tag_key,
            'Value': tag_value
        }
    ]

    # Connect to RDS service
    rds = boto3.client('rds')
    event_name = event.get("detail").get("eventName")

    if event_name == "CreateDBCluster":
        aurora_arn = event.get("detail").get("responseElements").get("dBClusterArn")
    # Add tags to the Regional Cluster
        try:
            rds.add_tags_to_resource(
                ResourceName=aurora_arn,
                Tags=tags
            )
            log.info('Tag adicionda com sucesso ao Cluster Aurora: %s', aurora_arn)
        except ClientError as error:
            log.exception(error)

    else:
    # Add tags to the RDS instance
        rds_arn = event.get("detail").get("responseElements").get("dBInstanceArn")
        try:
            rds.add_tags_to_resource(
                ResourceName=rds_arn,
                Tags=tags
            )
            log.info('Tag adicionda com sucesso ao RDS: %s', rds_arn)
        except ClientError as error:
            log.exception(error)
        