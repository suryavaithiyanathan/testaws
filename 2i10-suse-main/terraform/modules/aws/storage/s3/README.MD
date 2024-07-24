# README
This repository contains infrastructure as code for the generic module for deploying an S3 Bucket on AWS.
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
module binaries_bucket {
  source      = "./../../modules/aws/storage/s3"
  bucket_name = local.binaries_bucket_name
  versioning  = true

  policy = data.aws_iam_policy_document.binaries_bucket_policy.json

  kms_key_arn   = aws_kms_key.application_kms_key.arn
  attach_policy = true
  lifecycle_rules = [
    {
      prefix  = "/"
      enabled = true
      transitions = [
        {
          days          = 30
          storage_class = "GLACIER"
        }
      ]
      expiration = {
        days = 60
      }
    }
  ]
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
        * storage _- contains the generic modules that are specialized in the storage field_
            * s3 _- contains the module that will handle the deployment of an S3 Bucket on AWS_
                * bucket-policy.tf _- holds the configuration of the policy that will be applied to the Bucket to be deployed on AWS_
                * bucket.tf _- deploys the S3 bucket on AWS_
                * outputs.tf _- outputs the bucket id and ARN_
                * variables.tf _- contains the declaration of the variables that are being used in this module_