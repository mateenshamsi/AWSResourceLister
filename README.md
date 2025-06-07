# AWS Resource Lister

A simple Bash script to list various AWS resources in a specified region using the AWS CLI.

## Supported AWS Services

- EC2 Instances  
- S3 Buckets  
- RDS Databases  
- Lambda Functions  
- EBS Volumes  
- IAM Users  
- CloudFront Distributions  
- VPCs  
- Route53 Hosted Zones  
- CloudWatch Alarms  

## Prerequisites

- [AWS CLI](https://aws.amazon.com/cli/) installed and configured with appropriate credentials  
- Bash shell (Linux/macOS)  

## Usage

```bash
./aws-resource-lister.sh <region> <service_name>
