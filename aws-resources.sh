#!/bin/bash 

###############
#This script lists all AWS resources in the current region.
#Author:mateenshamsi
#Version: v0.0.1
#
#Supported AWS resources:
# 1. EC2 Instances
# 2. S3 Buckets
# 3. RDS Instances
# 4. Lambda Functions
# 5. EBS Volumes
# 6. IAM Users
# 7. CloudFront Distributions
# 8. VPCs
# 9. Route53 Hosted Zones
# 10. CloudWatch Alarms
#
#Usage: ./aws_resource_list.sh <region> <service_name>
#Example: ./aws_resource_list.sh us-east-1 ec2
#################

# Check if required no of arguments are passed 
if [ $# -ne 2];then 
    echo "Usage: $0 <region> <service_name>" 
    exit 1 
fi 

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null ; then 
    echo "AWS CLI is not installed. Please install it and try again." 
    exit 1 
fi

#Check if aws cli is configured
if [! -d ~/.aws ]; then 
    echo "AWS CLI is not configured. Please configure it and try again." 
    exit 1 
fi

#Execute the AWS CLI command to list resources based on the service name
case $2 in
    ec2)
        aws ec2 describe-instances --region $1 --query 'Reservations[*].Instances[*].[InstanceId,State.Name,PublicIpAddress,PrivateIpAddress,InstanceType,LaunchTime]' --output table
        ;;
    s3)
        aws s3api list-buckets --region $1 --query 'Buckets[*].[Name,CreationDate]' --output table 
        ;;
    rds)
        aws rds describe-db-instances --region $1 --query 'DBInstances[*].[DBInstanceIdentifier,DBInstanceClass,Engine,DBInstanceStatus,Endpoint.Address]' --output table
        ;;
    lambda)
        aws lambda list-functions --region $1 --query 'Functions[*].[FunctionName,Runtime,LastModified,State]' --output table
        ;;      
    ebs)
        aws ec2 describe-volumes --region $1 --query 'Volumes[*].[VolumeId,Size,State,CreateTime]' --output table
        ;;
    iam)
        aws iam list-users --region $1 --query 'Users[*].[UserName,CreateDate]' --output table
        ;;
    cloudfront)
        aws cloudfront list-distributions --region $1 --query 'DistributionList.Items[*].[Id,Status,DomainName,LastModifiedTime]' --output table                
        ;;

    vpc)
        aws ec2 describe-vpcs --region $1 --query 'Vpcs[*].[VpcId,State,CidrBlock,InstanceTenancy]' --output table
        ;;
    route53)
        aws route53 list-hosted-zones --region $1 --query 'HostedZones[*].[Id,Name,Config.PrivateZone]' --output table
        ;;
    cloudwatch)
        aws cloudwatch describe-alarms --region $1 --query 'MetricAlarms[*].[AlarmName,StateValue,StateUpdatedTimestamp]' --output table
        ;;
    *)
        echo "Unsupported service name. Supported services are: ec2, s3, rds, lambda, ebs, iam, cloudfront, vpc, route53, cloudwatch."
        exit 1
        ;;
esac    