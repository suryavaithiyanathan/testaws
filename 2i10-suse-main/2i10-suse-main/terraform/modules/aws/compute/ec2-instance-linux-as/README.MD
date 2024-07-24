# README
This repository contains infrastructure as code for the generic module for creating an EC2 Instance in AWS.
## Getting Started
  You can easily create your own configuration for an SAP application in `terraform/configuration/applications` folder by creating a new application and adding the required modules into your config
  Please use `extended-warehouse-management` as a reference
## Contribution guidelines
* Always make changes on a short lived branch - relating to a SNOW ticket/JIRA User Story when possible
* Always create pull request and seek approval before merge via a peer review
* When provisioning new infrastructure please include tests to confirm provisioning has worked as expected
* Always leave code in a better state than you found it if possible
* Use a clean code approach (descriptive naming for readability and reduce need for unnecessary comments)
* Unnecessary comments increase maintenance
* run the following command on the module root before pushing to the short lived branch:
  ```
  terraform fmt --recursive
  ```
### Usage:

 - Add this module to your terraform configuration and provide the variables:

 ```json
module instance {
  source = "../../../../../../modules/aws/compute/ec2-instance-linux"

  enabled                = var.enabled
  kms_key_arn            = var.kms_key_arn
  ami                    = var.ami_id
  ebs_optimized          = var.ebs_optimized
  instance_type          = var.instance_type[var.environment]
  root_volume_size       = var.root_volume_size
  instance_count         = var.enabled ? var.instance_count[var.environment] : 0
  subnet_ids             = var.local_subnet_ids
  vpc_security_group_ids = [aws_security_group.instance.*.id[0], aws_security_group.sap_application.*.id[0], data.aws_security_group.mandatory_sg.id, data.aws_security_group.self_sg.id]
  iam_role               = var.iam_instance_role
  hostnames              = local.hostnames
  user_data              = "\"logFolder\":[\"\"]"

  tags = merge(module.tags.values)
}
```

## Organising the code
* The following file structure should be followed as closely as possible
* The structure selected is optimal for short live feature branching in git
* The structure contains multiple terraform configurations for different applications and modules inside them
* Create and Update README.MD files for the modules inside the configuration
  * terraform
    * modules _- contains the generic modules that can be reused anywhere in the modules that are in the configuration folder_
      * aws _- contains the generic modules that are specific for AWS, in case another CSP is retained a different folder needs to be created in the arborescence and same logic should be applied_
        * compute _- contains the generic modules that are specialized in the compute_
            * ec2-instance-linux _- contains the module that will handle the deployment of an EC2 Linux Instance in AWS independently from its configuration_
                * auto-recovery.tf _- contains the configuration of the host auto-failover configuration allowing AWS to automatically recover the instance in case of hardware failure_
                * instance_profile.tf _- contains the configuration to deploy an instance profile that will be mapped to the instance_
                * instance.tf _- contains the configuration of the EC2 Instance on AWS_
                * outputs.tf _- outputs the availability zone, private_ip, instance_id, instance_name and the instance_profile associated to the EC2 Instance_
                * region.tf _- contains the Region data source_
                * variables.tf _- contains the declaration of the variables that are being used in this module_

### Improvements
* Create an SNS Topic and have it push a notification to the Run Team in case of Host Failover or Infra Issues.
* Inject the EC2 OS Logs into the Elasticsearch domain for log analysis together with the VPC Flow Logs.