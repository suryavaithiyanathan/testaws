# README
This repository contains infrastructure as code for the generic module for deploying an Elastic File System on AWS.
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
module sap_netweaver_efs {
  source = "../../../../../modules/aws/storage/efs"

  enabled     = var.enabled
  kms_key_arn = var.kms_key_arn
  aws_region  = var.aws_region
  subnet_ids  = var.subnet_ids
  vpc_id      = var.vpc_id
  name        = module.tags.values["Name"]
  efs_file_system_id    = ""
  efs_security_group_id = aws_security_group.efs.id

  tags = module.tags.values
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
        * storage _- contains the generic modules that are specialized in the storage field_
            * efs _- contains the module that will handle the deployment of an Elastic File System on AWS_
                * main.tf _- holds the configuration of the EFS to be deployed on AWS_
                * outputs.tf _- outputs the efs_file_system_id_
                * variables.tf _- contains the declaration of the variables that are being used in this module_